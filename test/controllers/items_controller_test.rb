require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @first_item = items(:one)
    # use in post req
    @name, @description = [items(:three).name, items(:three).description]
    # get token to use in different requests
    @bruno = users(:bruno)
    sign_in_as(@bruno)
  end

  test "should get index if valid token" do
    get items_url, as: :json, headers: {Authorization: @valid_token.to_s}
    assert_response :success
    # response yields all items
    assert_equal items.count, JSON.parse(@response.body).count
    # item content is same as in fixture
    assert_equal items[0].description, JSON.parse(@response.body)[0]["description"]
  end

  test "should create item" do
    assert_difference("Item.count") do
      post items_url,
        headers: {Authorization: @valid_token.to_s},
        params: {
          item: {description: @description, name: @name},
        },
        as: :json
    end

    assert_response 201
  end

  test "should show item" do
    get item_url(items),
      headers: {Authorization: @valid_token.to_s},
      as: :json
    assert_response :success
  end

  test "should update item" do
    patch item_url(@first_item),
      headers: {Authorization: @valid_token.to_s},
      params: {
        item: {
          name: @name,
          description: @description,
        },
      },
      as: :json
    assert_response 200
  end

  test "should destroy item" do
    assert_difference("Item.count", -1) do
      delete item_url(@first_item),
        headers: {Authorization: @valid_token.to_s},
        as: :json
    end

    assert_response 204
  end
end
