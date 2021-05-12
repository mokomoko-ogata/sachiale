crumb :root do
  link "Home", root_path
end

crumb :sign_up do
  link "新規ユーザー登録", new_user_registration_path
  parent :root
end

crumb :sign_in do
  link "サインインページ", new_user_session_path
  parent :root
end

crumb :blog_new do
  link "レシピ投稿ページ", new_blog_path
  parent :root
end

crumb :blog do
  link "レシピ詳細ページ", blog_path(:id)
  parent :root
end

crumb :edit_blog do
  link "レシピ編集ページ", edit_blog_path(:id)
  parent :blog
end

crumb :items do
  link "食材一覧ページ", items_path
  parent :root
end

crumb :new_item do
  link "食材補充ページ", new_item_path
  parent :items
end

crumb :item do
  link "食材詳細ページ", item_path
  parent :items
end

crumb :edit_item do
  link "食材編集ページ", edit_item_path
  parent :item
end

crumb :items_search do
  link "食材検索結果ページ", items_search_path
  parent :items
end

crumb :buys_list do
  link "買い物リスト一覧ページ", buys_list_index_path
  parent :items
end

crumb :new_buys_list do
  link "買い物リスト追加ページ", new_buys_list_path
  parent :buys_list
end

crumb :edit_buys_list do
  link "買い物リスト編集ページ", edit_buys_list_path
  parent :buys_list
end


# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).