# README

## MapPlayHouse

뮤지컬 동호회원들을 위한 웹앱

구현할 목록

- 카카오톡 회원가입
- 유저별 role
- 작품(뮤지컬)별 신청, 어드민 승인
- 연습실 대관신청 및 어드민 승인 및 거부
- 기수별 대표 사진과 영상 업로드
- 어드민 페이지

## Generator

새로운 Controller 만들 때

`rails g api v1/items`

새로은 Serializer 만들 때

`rails g serializer v1/item`

###

## PankoSerializer

action 에서 `render json: @object` 시 모델의 모든 내용이 response

`render json: @object.as_json(only: [:id, :name, ... ], includes: [:comments], methods: [:image_path])` (or to_json) 등으로 serializatio하여 응답할 수 있지만 가독성 및 재활용이 어려움

따라서 serializing 을 돕는 gem을 사용. 몇가지 gem이 있는데 대표적으로 `active_model_serializers`

직접 사용, 비교 해봤을 때 불편한 것이 많아서 `panko_serializer` 로 결정

`app/serializers/...` 에 serializer 위치 기본 예시

```ruby
class V1::ItemSerializer < V1::BaseSerializer
  attributes :id, :title, :price, :image_path, :description
  has_one :category, serializer: V1::CategorySerializer
  has_many :images, each_serializer: V1::ImageEachSerializer
  def image_path
    object.image_path
  end
end
```

### basic rules

- serializer naming 규칙

  - index - active record relation ( array ) 에 대한 serializer 는 #{모델이름}EachSerializer 로 짓는다
  - show - active record 하나 에 대한 serialzer 는 #{모델이름}Serializer 로 짓는다
  - 이 두가지는 인덱스에서 보여주는 정보와 상세 페이지에서 보여주는 정보가 크게 차이가 나기때문에 구분,
  - 두가지 경우 제외하고도 필요 하다면 만들 수 있음, 하지만 serializer가 크게 다른게 아니라면 filter를 사용해서 활용 가능
    - https://panko.dev/docs/attributes#filters

- `api_controller` method 만들어 놓음 활용

```ruby
def serialize object, serializer_name = "#{object.class.name}Serializer"
  self.class.module_parent.const_get("#{serializer_name}").new.serialize(object)
end

def each_serialize objects, serializer_name: "#{objects.name}EachSerializer"
  Panko::ArraySerializer.new(
    objects,
    each_serializer: self.class.module_parent.const_get(serializer_name)
  ).to_a
end
```

PankoSerializer의 상세한 사용법은 링크 참고

[github]: https://github.com/panko-serializer/panko_serializer
[docs]: https://panko.dev/docs/
