# 🕰️ WatchApp

A comprehensive single-page web application for discovering and exploring wristwatch models from around the world. WatchApp provides detailed specifications, advanced search and filtering capabilities, and is designed to be embeddable into Shopify stores.

## 🚀 Features

- **Comprehensive Watch Database**: Browse detailed specifications including:
  - Year of manufacture
  - Dimensions (case diameter, thickness, lug width)
  - Reference numbers
  - Caliber information
  - Movement type
  - Features and complications
  - Detailed descriptions

- **Advanced Search & Filtering**:
  - Text search across brands, models, calibers, and reference numbers
  - Filter by brand, year, and movement type
  - Real-time search results

- **Responsive Design**: 
  - Clean, modern interface
  - Mobile-friendly responsive layout
  - Optimized for all screen sizes

- **Pagination**: 
  - Efficient handling of large datasets
  - Configurable items per page

- **API-First Architecture**: 
  - RESTful JSON API
  - CORS-enabled for cross-origin requests
  - Ready for Shopify App Proxy integration

## 🛠️ Tech Stack

### Backend
- **Framework**: Ruby on Rails 8.0 (API mode)
- **Database**: SQLite3 (development), PostgreSQL (production)
- **Pagination**: Kaminari gem
- **CORS**: Rack-CORS for cross-origin support

### Frontend
- **Framework**: React 18 with Vite
- **Styling**: Custom CSS with responsive design
- **Build Tool**: Vite for fast development and optimized builds

### Deployment Ready
- **Containerization**: Docker support included
- **Cloud Platforms**: Compatible with Render, Fly.io, Heroku
- **CI/CD**: GitHub Actions workflow included

## 📦 Installation & Setup

### Prerequisites
- Ruby 3.2+
- Node.js 18+
- SQLite3 (development)
- PostgreSQL (production)

### Backend Setup

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd WatchApp
   ```

2. **Install Ruby dependencies**:
   ```bash
   bundle install
   ```

3. **Setup the database**:
   ```bash
   rails db:create db:migrate db:seed
   ```

4. **Start the Rails API server**:
   ```bash
   rails server
   ```
   The API will be available at `http://localhost:3000`

### Frontend Setup

1. **Navigate to the frontend directory**:
   ```bash
   cd frontend
   ```

2. **Install Node.js dependencies**:
   ```bash
   npm install
   ```

3. **Start the development server**:
   ```bash
   npm run dev
   ```
   The frontend will be available at `http://localhost:5173`

## 🔌 API Documentation

### Base URL
- Development: `http://localhost:3000/api/v1`
- Production: `https://your-domain.com/api/v1`

### Endpoints

#### GET /watches
Retrieve a paginated list of watches with optional filtering and search.

**Query Parameters**:
- `search` (string): Search across brand, model, caliber, and reference number
- `brand` (string): Filter by specific brand
- `year` (integer): Filter by specific year
- `movement_type` (string): Filter by movement type (e.g., "Automatic", "Manual")
- `page` (integer): Page number (default: 1)
- `per_page` (integer): Items per page (default: 20, max: 100)

**Example Requests**:
```bash
# Get all watches
curl "http://localhost:3000/api/v1/watches"

# Search for Rolex watches
curl "http://localhost:3000/api/v1/watches?search=Rolex"

# Filter by brand and year
curl "http://localhost:3000/api/v1/watches?brand=Omega&year=2019"

# Paginated results
curl "http://localhost:3000/api/v1/watches?page=2&per_page=10"
```

**Response Format**:
```json
{
  "watches": [
    {
      "id": 1,
      "brand": "Rolex",
      "model": "Submariner",
      "full_name": "Rolex Submariner",
      "year": 2020,
      "case_diameter": "40.0",
      "case_thickness": "12.5",
      "lug_width": "20.0",
      "reference_number": "114060",
      "caliber": "3130",
      "movement_type": "Automatic",
      "features": "Unidirectional rotating bezel, Triplock crown",
      "complications": "None",
      "description": "Professional diving watch with 300m water resistance",
      "created_at": "2025-06-10T14:48:56.953Z",
      "updated_at": "2025-06-10T14:48:56.953Z"
    }
  ],
  "meta": {
    "current_page": 1,
    "total_pages": 1,
    "total_count": 5,
    "per_page": 20
  }
}
```

#### GET /watches/:id
Retrieve a specific watch by ID.

**Example**:
```bash
curl "http://localhost:3000/api/v1/watches/1"
```

## 🐳 Docker Deployment

### Development
```bash
# Build and run with Docker Compose (if configured)
docker-compose up --build
```

### Production
```bash
# Build the production image
docker build -t watchapp .

# Run the container
docker run -p 3000:3000 -e RAILS_ENV=production watchapp
```

## ☁️ Cloud Deployment

### Render.com
1. Connect your GitHub repository to Render
2. Create a new Web Service
3. Set build command: `bundle install && npm install --prefix frontend && npm run build --prefix frontend`
4. Set start command: `bundle exec rails server -p $PORT -e $RAILS_ENV`

### Fly.io
```bash
# Install Fly CLI and login
fly auth login

# Deploy the application
fly deploy
```

### Heroku
```bash
# Create Heroku app
heroku create your-watchapp

# Add PostgreSQL addon
heroku addons:create heroku-postgresql:hobby-dev

# Deploy
git push heroku main
```

## 🔧 Configuration

### Environment Variables

**Development**: Set in `.env` file
**Production**: Set via your hosting platform

```bash
# Database (Production)
DATABASE_URL=postgresql://user:password@host:port/database

# Rails
RAILS_ENV=production
SECRET_KEY_BASE=your-secret-key

# Optional: API rate limiting, caching, etc.
REDIS_URL=redis://localhost:6379/0
```

### CORS Configuration
CORS is configured to allow all origins by default. For production, update `config/initializers/cors.rb`:

```ruby
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'your-domain.com', 'your-shopify-store.myshopify.com'
    
    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```

## 🛍️ Shopify Integration

### App Proxy Setup
1. Create a Shopify App in your Partner Dashboard
2. Configure App Proxy:
   - Subpath: `apps/watchapp`
   - Subpath prefix: `apps`
   - Proxy URL: `https://your-domain.com/`

3. Update your frontend to handle Shopify's liquid templates and theme integration

### Storefront API Integration
Use Shopify's Storefront API to integrate watch data with your store's products:

```javascript
// Example: Link watches to Shopify products
const shopifyProduct = await fetch('/api/products/watch-123.json')
const watchSpecs = await fetch('/api/v1/watches?search=' + productTitle)
```

## 📚 Project Structure

```
WatchApp/
├── app/                    # Rails application
│   ├── controllers/        # API controllers
│   │   └── api/v1/        # Versioned API
│   └── models/            # Active Record models
├── config/                # Rails configuration
├── db/                    # Database migrations and seeds
├── frontend/              # React application
│   ├── src/              # React source code
│   └── public/           # Static assets
├── Dockerfile            # Container configuration
├── Gemfile              # Ruby dependencies
└── README.md           # This file
```

## 🧪 Testing

### Backend Tests
```bash
# Run Rails tests
rails test

# Run specific test
rails test test/models/watch_test.rb
```

### Frontend Tests
```bash
cd frontend
npm test
```

## 🚀 Performance Optimization

### Database Optimization
- Indexes on searchable fields (brand, model, year, etc.)
- Pagination to limit query results
- Database query optimization with `includes` for associations

### Frontend Optimization
- Vite for fast builds and hot module replacement
- Lazy loading for large lists
- Responsive images and optimized assets

### Caching Strategy
- Redis for session storage and caching
- HTTP caching headers for API responses
- CDN integration for static assets

## 🔄 Future Enhancements

### Phase 2 Features
- [ ] User authentication and favorites
- [ ] Advanced filtering (price range, complications)
- [ ] Image upload and management with Active Storage
- [ ] Full-text search with Elasticsearch/Meilisearch
- [ ] Watch comparison feature
- [ ] Export functionality (CSV, PDF)

### Shopify Integration
- [ ] Product variant linking
- [ ] Inventory management
- [ ] Price synchronization
- [ ] Customer wishlist integration

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/new-feature`
3. Commit changes: `git commit -am 'Add new feature'`
4. Push to branch: `git push origin feature/new-feature`
5. Submit a Pull Request

## 📄 License

This project is licensed under the MIT License. See the LICENSE file for details.

## 📞 Support

For support and questions:
- Create an issue on GitHub
- Email: support@watchapp.com
- Documentation: [docs.watchapp.com](https://docs.watchapp.com)

---

**Built with ❤️ for watch enthusiasts worldwide** 🌍
