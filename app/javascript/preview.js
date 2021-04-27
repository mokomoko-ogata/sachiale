document.addEventListener('DOMContentLoaded', function(){
  if (document.getElementById('item-image')) {
    const ImagePreview = document.getElementById('image-preview');

    const createImageHTML = (blob) => {
      const imageElement = document.createElement('div');// 画像を表示するためのdiv要素を生成
      const blobImage = document.createElement('img');// 表示する画像を生成
      blobImage.setAttribute('src', blob);
      imageElement.appendChild(blobImage);
      ImagePreview.appendChild(imageElement);// 生成したHTMLの要素をブラウザに表示させる
    };

    document.getElementById('item-image').addEventListener('change', function(e){
      const imageContent = document.querySelector('img');
      if (imageContent) {
        imageContent.remove();// 画像が表示されている場合のみ、すでに存在している画像を削除する
      }

      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      
      createImageHTML(blob);
    });
  }
});