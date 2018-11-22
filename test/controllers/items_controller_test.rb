require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @first_item = items(:one)
    @third_item = items(:three)
    @third_item = items(:updated_item)
    @user = users(:one)
    # use in post req
    @name = items(:three).name
    @description = items(:three).description
    # get token to use in different requests
    sign_in_as(@user)
  end

  test "should get index if valid token" do
    get items_url, as: :json, headers: {Authorization: "#{@valid_token}"}
    assert_response :success
    # response yields all items
    assert_equal items.count, JSON.parse(@response.body).count
    # item content is same as in fixture
    assert_equal items[0].description, JSON.parse(@response.body)[0]["description"]
  end

  test "should create item" do
    assert_difference('Item.count') do
      post items_url,  
        headers: {Authorization: "#{@valid_token}"}, 
        params: { 
          item: { description: @description, name: @name } 
        }, 
        as: :json
    end
    
    assert_response 201
  end

  test "should show item" do
    get item_url(@first_item), 
      headers: {Authorization: "#{@valid_token}"}, 
      as: :json
    assert_response :success
  end

  test "should update item" do
    patch item_url(@first_item),
    headers: {Authorization: "#{@valid_token}"}, 
    params: {
      item: {
        name: @updated_item.name,
        description: @updated_item.description
      } 
    }, 
    as: :json
    assert_response 200
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete item_url(@third_item),
        headers: {Authorization: "#{@valid_token}"},
        as: :json
    end

    assert_response 204
  end
end
