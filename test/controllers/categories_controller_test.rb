require 'test_helper'
class CategoriesControllerTest < ActionController::TestCase
def setup
@category = Category.create(name: "sports")
end
test "should get categories index" do
get :index
assert_response :success
end
test "should get new" do
get :new
assert_response :success
end
test "should get show" do
get(:show, {'id' => @category.id})
assert_response :success
end
test "invalid category submission results in failure" do
get new_category_path
assert_template 'categories/new'
assert_no_difference 'Category.count' do
post categories_path, category: {name: " "}
end
assert_template 'categories/new'
assert_select 'h2.panel-title'
assert_select 'div.panel-body'
end
end