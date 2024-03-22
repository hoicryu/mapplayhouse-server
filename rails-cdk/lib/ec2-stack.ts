import {
  BlockDevice,
  BlockDeviceVolume,
  CfnEIP,
  CfnEIPAssociation,
  GenericLinuxImage,
  IInstance,
  Instance,
  InstanceClass,
  InstanceSize,
  InstanceType,
  ISecurityGroup,
  IVpc,
  SubnetType,
} from '@aws-cdk/aws-ec2';
import * as cdk from '@aws-cdk/core';
import { BaseStackProps } from './base-stack-props';

interface EC2StackProps extends BaseStackProps {
  vpc: IVpc;
  webSG: ISecurityGroup;
}

export class Ec2Stack extends cdk.Stack {
  publicIp: string;

  ec2Instance: Instance;

  constructor(scope: cdk.Construct, id: string, props: EC2StackProps) {
    super(scope, id, props);
    const { context, vpc, webSG } = props;

    const machineImage = new GenericLinuxImage({
      [this.region]: 'ami-00e2356d85d0cb4ba',
    });

    const instanceId = `${context.appName}-instance`;

    const rootVolume: BlockDevice = {
      deviceName: '/dev/xvda',
      volume: BlockDeviceVolume.ebs(64),
    };

    const instance = new Instance(this, instanceId, {
      // 실서버 세팅
      instanceType: InstanceType.of(InstanceClass.T3, InstanceSize.MEDIUM),
      // 테스트서버 세팅
      // instanceType: InstanceType.of(InstanceClass.T3, InstanceSize.MICRO),
      machineImage,
      vpc,
      vpcSubnets: {
        subnetType: SubnetType.PUBLIC,
      },
      allowAllOutbound: true,
      instanceName: context.appName,
      securityGroup: webSG,
      blockDevices: [rootVolume],
    });
    this.ec2Instance = instance;

    instance.addUserData(`echo '${context.sshKey}' >> /home/deploy/.ssh/authorized_keys`);
    const eip = new CfnEIP(this, `${context.appName}ec2Eip`);

    const ec2Assoc = new CfnEIPAssociation(this, `${context.appName}Ec2Assciation`, {
      eip: eip.ref,
      instanceId: instance.instanceId,
    });

    cdk.Tags.of(this).add('Name', instanceId, {
      includeResourceTypes: ['AWS::EC2::Instance'],
    });

    this.publicIp = instance.instancePublicIp;

    new cdk.CfnOutput(this, 'PublicIp', {
      value: instance.instancePublicIp,
      description: 'public ip of instance',
      exportName: `${context.appName}ec2-public-ip`,
    });
  }
}