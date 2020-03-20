RSpec.describe 'POST /articles', type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  let(:image) do
    {
      type: 'application/jpg',
      encoder: 'name=new_iphone.jpg;base64',
      data: 'iVBORw0KGgoAAAANSUhEUgAABjAAAAOmCAYAAABFYNwHAAAgAElEQVR4XuzdB3gU1cLG8Te9EEgISQi9I71KFbBXbFixN6zfvSiIjSuKInoVFOyIDcWuiKiIol4Q6SBVOtI7IYSWBkm',
      extension: 'jpg'
    }
  end

  describe 'with valid params' do
    before do
      post '/api/v1/articles',
      params: {
        article: {
          title: "Corona",
          content: "It is everywhere",
          image: image
        }
      },
      headers: headers
    end

    it 'return a 200 response' do
      expect(response.status).to eq 200
    end

    it 'returns a success message' do
      expect(response_json['message']).to eq 'Your article was successfully created'
    end

    it 'article has an image attached to it' do
      article = Article.where(title: response.request.params['article']['title'])
      expect(article.first.image.attached?).to eq true
    end
  end
end