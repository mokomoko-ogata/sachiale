document.addEventListener('DOMContentLoaded', function(){
  if ( document.getElementById('category-form')){
      document.getElementById('item-category').addEventListener('change', function(){
      const category = document.getElementById('item-category').value;
      console.log(category)
    });
  }
}); 