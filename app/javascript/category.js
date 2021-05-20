document.addEventListener('DOMContentLoaded', function(){
  if ( document.getElementById('category-form')){
    document.getElementById('item-category').addEventListener('change', function(){
      const category = document.getElementsByName('item[category_id]').value;
      console.log(category)
    });
  }
}); 