import { useState, useEffect } from 'react'
import './App.css'

function App() {
  const [watches, setWatches] = useState([])
  const [searchTerm, setSearchTerm] = useState('')
  const [brandFilter, setBrandFilter] = useState('')
  const [yearFilter, setYearFilter] = useState('')
  const [movementFilter, setMovementFilter] = useState('')
  const [currentPage, setCurrentPage] = useState(1)
  const [totalPages, setTotalPages] = useState(1)
  const [loading, setLoading] = useState(false)

  const API_BASE_URL = '/api/v1'

  const fetchWatches = async (page = 1) => {
    setLoading(true)
    try {
      const params = new URLSearchParams()
      if (searchTerm) params.append('search', searchTerm)
      if (brandFilter) params.append('brand', brandFilter)
      if (yearFilter) params.append('year', yearFilter)
      if (movementFilter) params.append('movement_type', movementFilter)
      params.append('page', page)
      params.append('per_page', 10)

      const response = await fetch(`${API_BASE_URL}/watches?${params}`)
      const data = await response.json()
      
      setWatches(data.watches)
      setCurrentPage(data.meta.current_page)
      setTotalPages(data.meta.total_pages)
    } catch (error) {
      console.error('Error fetching watches:', error)
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchWatches(1)
  }, [searchTerm, brandFilter, yearFilter, movementFilter])

  const handlePageChange = (page) => {
    fetchWatches(page)
  }

  const clearFilters = () => {
    setSearchTerm('')
    setBrandFilter('')
    setYearFilter('')
    setMovementFilter('')
  }

  return (
    <div className="watch-app">
      <header className="app-header">
        <h1>🕰️ WatchApp</h1>
        <p>Discover and explore wristwatch models from around the world</p>
      </header>

      <div className="filters">
        <div className="search-bar">
          <input
            type="text"
            placeholder="Search watches..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="search-input"
          />
        </div>
        
        <div className="filter-controls">
          <select
            value={brandFilter}
            onChange={(e) => setBrandFilter(e.target.value)}
            className="filter-select"
          >
            <option value="">All Brands</option>
            <option value="Rolex">Rolex</option>
            <option value="Omega">Omega</option>
            <option value="Seiko">Seiko</option>
            <option value="Patek Philippe">Patek Philippe</option>
            <option value="Tudor">Tudor</option>
          </select>

          <select
            value={yearFilter}
            onChange={(e) => setYearFilter(e.target.value)}
            className="filter-select"
          >
            <option value="">All Years</option>
            <option value="2021">2021</option>
            <option value="2020">2020</option>
            <option value="2019">2019</option>
            <option value="2018">2018</option>
          </select>

          <select
            value={movementFilter}
            onChange={(e) => setMovementFilter(e.target.value)}
            className="filter-select"
          >
            <option value="">All Movements</option>
            <option value="Automatic">Automatic</option>
            <option value="Manual">Manual</option>
          </select>

          <button onClick={clearFilters} className="clear-filters">
            Clear Filters
          </button>
        </div>
      </div>

      {loading ? (
        <div className="loading">Loading watches...</div>
      ) : (
        <>
          <div className="watch-grid">
            {watches.map((watch) => (
              <div key={watch.id} className="watch-card">
                <h3 className="watch-title">{watch.full_name}</h3>
                <div className="watch-details">
                  <p><strong>Year:</strong> {watch.year}</p>
                  <p><strong>Reference:</strong> {watch.reference_number}</p>
                  <p><strong>Caliber:</strong> {watch.caliber}</p>
                  <p><strong>Movement:</strong> {watch.movement_type}</p>
                  <p><strong>Case Diameter:</strong> {watch.case_diameter}mm</p>
                  <p><strong>Lug Width:</strong> {watch.lug_width}mm</p>
                  {watch.complications && watch.complications !== 'None' && (
                    <p><strong>Complications:</strong> {watch.complications}</p>
                  )}
                  {watch.features && (
                    <p><strong>Features:</strong> {watch.features}</p>
                  )}
                  {watch.description && (
                    <p className="watch-description">{watch.description}</p>
                  )}
                </div>
              </div>
            ))}
          </div>

          {totalPages > 1 && (
            <div className="pagination">
              <button
                onClick={() => handlePageChange(currentPage - 1)}
                disabled={currentPage === 1}
                className="pagination-btn"
              >
                Previous
              </button>
              
              <span className="page-info">
                Page {currentPage} of {totalPages}
              </span>
              
              <button
                onClick={() => handlePageChange(currentPage + 1)}
                disabled={currentPage === totalPages}
                className="pagination-btn"
              >
                Next
              </button>
            </div>
          )}
        </>
      )}
    </div>
  )
}

export default App
