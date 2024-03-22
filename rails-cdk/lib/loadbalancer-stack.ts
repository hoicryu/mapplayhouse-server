import * as route53 from '@aws-cdk/aws-route53';
import * as cdk from '@aws-cdk/core';
import * as acm from '@aws-cdk/aws-certificatemanager';
import * as ec2 from '@aws-cdk/aws-ec2';
import * as elbv2 from '@aws-cdk/aws-elasticloadbalancingv2';
import * as elb_targets from '@aws-cdk/aws-elasticloadbalancingv2-targets';
import * as route53_targets from '@aws-cdk/aws-route53-targets';
import { BaseStackProps } from './base-stack-props';

interface Route53Props extends BaseStackProps {
  vpc: ec2.IVpc;
  ec2Instance: ec2.Instance;
  webSG: ec2.ISecurityGroup;
}

export class LoadBalancerStack extends cdk.Stack {
  constructor(scope: cdk.Construct, id: string, props: Route53Props) {
    super(scope, id, props);

    const { context, vpc, ec2Instance, webSG } = props;

    const hostedZone = route53.HostedZone.fromLookup(this, `${context.appName}HostZone`, {
      domainName: context.domain!,
    });

    const elb = new elbv2.ApplicationLoadBalancer(this, `${context.appName}elb`, {
      vpc,
      internetFacing: true,
      securityGroup: webSG,
    });

    const certificate = new acm.Certificate(this, `${context.appName}-elb-acm`, {
      domainName: context.url!,
      validation: acm.CertificateValidation.fromDns(hostedZone),
    });

    const domainNames = [context.url!];

    const listener = elb.addListener(`${context.appName}listner`, {
      port: 443,
      open: true,
      certificateArns: [certificate.certificateArn],
    });

    listener.addTargets(`${context.appName}targets`, {
      targets: [new elb_targets.InstanceTarget(ec2Instance)],
      port: 80,

      protocol: elbv2.ApplicationProtocol.HTTP,
      healthCheck: {
        path: '/nginx-health',
      },
    });

    const httpListener = elb.addListener(`${context.appName}HttpListner`, {
      port: 80,
      open: true,
    });

    httpListener.addAction('http', {
      action: elbv2.ListenerAction.redirect({
        protocol: 'HTTPS',
        host: context.url!,
        port: '443',
      }),
    });

    new route53.ARecord(this, `${context.appName}elb-record`, {
      recordName: context.url!,
      zone: hostedZone,
      target: route53.RecordTarget.fromAlias(new route53_targets.LoadBalancerTarget(elb)),
    });
  }
}