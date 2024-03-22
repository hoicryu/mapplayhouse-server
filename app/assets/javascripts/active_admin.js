//= require active_admin/base
//= require activeadmin_addons/all
//= require active_material
//= require imageviewer
//= require activeadmin_reorderable

$(function daumMap(model) {
  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });

  let viewer = ImageViewer();
  $('img').click(function () {
      let imgSrc = this.src
      viewer.show(imgSrc);
  });

  var daum_postcode = {
    foldDaumPostcode: function (wrap) {
      // iframe을 넣은 element를 안보이게 한다.
      wrap.style.display = 'none';
    },
    freshDaumPostcode: function (wrap) {
      // 현재 scroll 위치를 저장해놓는다.
      var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
      daum.postcode.load(function () {
        new daum.Postcode({
          oncomplete: function (data) {
            // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분. 각 주소의 노출 규칙에 따라 주소를 조합한다. 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = data.address; // 최종 주소 변수
            var enFullAddr = data.roadAddressEnglish;
            var extraAddr = ''; // 조합형 주소 변수
            // 기본 주소가 도로명 타입일때 조합한다.
            if (data.addressType === 'R') {
              //법정동명이 있을 경우 추가한다.
              if (data.bname !== '') {
                extraAddr += data.bname;
              }
              // 건물명이 있을 경우 추가한다.
              if (data.buildingName !== '') {
                extraAddr += (
                  extraAddr !== '' ?
                  ', ' + data.buildingName :
                  data.buildingName
                );
              }
              // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
              fullAddr += (
                extraAddr !== '' ?
                ' (' + extraAddr + ')' :
                ''
              );
            }
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            $("#stadium_zipcode").val(data.zonecode);
            $("#stadium_address1").val(fullAddr);
            $("#stadium_address2").focus();
  
            // iframe을 넣은 element를 안보이게 한다. (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
            wrap.style.display = 'none';
            // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
            document.body.scrollTop = currentScroll;
          },
          // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
          onresize: function (size) {
            wrap.style.height = size.height + 'px';
          },
          width: '100%',
          height: '100%'
        }).embed(wrap);
      });
      // iframe을 넣은 element를 보이게 한다.
      wrap.style.display = 'block';
    }
  };
  
  $(document).on("click", "#zipcode_button", function () {
    daum_postcode.freshDaumPostcode(document.getElementById('daum_wrap'));
  });
});

$(document).ready(function() {
  // $('#reservation_stadium_id').on("change", function(e) {
  //   $('#reservation_court_id').html('')
  //   $.ajax ({
  //     url: '/admin/reservations/get_court_list_by_stadium_id',
  //     type: 'GET',
  //     data: { stadium_id: e.target.value},
  //     dataType: 'json',
  //     success: (res) => {
  //       res.map((court) => {
  //         $('#reservation_court_id').append('<option selected="selected" value="" data-select2-id=""></option>')
  //         $('#reservation_court_id').append(`<option value=${court.name} data-select2-id=${court.id}></option>`);
  //       })
  //     }
  //   })
  // })
})