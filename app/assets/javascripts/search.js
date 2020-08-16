$(function(){

  function buildHTML(good) {
    let html = `
    <a href="/goods/${good.id}">
      <img src="${good.image.url}" class="goodImage">
    </a>`
    $('.LineUpWrapper__grid').append(html);
  }

  function appendNoFoundMsgToHTML(message) {
    let html = `<div class='NoFoundMsg'>${ message }</div>`;
    $('.SearchContent').append(html);
  }

  $('#SearchBox__input').on('keyup', function(){
    let input = $('#SearchBox__input').val();
    $.ajax({
      type: 'GET',
      url: '/goods/search',
      data: {keyword: input},
      dataType: 'json'
    })
    .done(function(goods){
      $('.LineUpWrapper__grid').empty();
      $('.NoFoundMsg').remove();
      if (goods.length !== 0) {
        goods.forEach(function(good){
          buildHTML(good);
        });
      } else {
        appendNoFoundMsgToHTML('条件に一致する商品はありません');
      }
    })
    .fail(function(){
      alert('エラー');
    });
  });
});