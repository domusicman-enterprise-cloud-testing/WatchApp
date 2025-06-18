# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Sample watch data
watches_data = [
  {
    brand: "Rolex",
    model: "Submariner",
    year: 2020,
    case_diameter: 40.0,
    case_thickness: 12.5,
    lug_width: 20.0,
    reference_number: "114060",
    caliber: "3130",
    movement_type: "Automatic",
    features: "Unidirectional rotating bezel, Triplock crown",
    complications: "None",
    description: "Professional diving watch with 300m water resistance"
  },
  {
    brand: "Omega",
    model: "Speedmaster Professional",
    year: 2019,
    case_diameter: 42.0,
    case_thickness: 13.18,
    lug_width: 20.0,
    reference_number: "311.30.42.30.01.005",
    caliber: "1861",
    movement_type: "Manual",
    features: "Tachymeter bezel, Hesalite crystal",
    complications: "Chronograph",
    description: "The Moonwatch - worn on all six lunar missions"
  },
  {
    brand: "Seiko",
    model: "SKX007",
    year: 2018,
    case_diameter: 42.0,
    case_thickness: 13.0,
    lug_width: 22.0,
    reference_number: "SKX007K2",
    caliber: "7S26",
    movement_type: "Automatic",
    features: "Unidirectional bezel, Day/Date display",
    complications: "Day-Date",
    description: "Iconic dive watch with 200m water resistance"
  },
  {
    brand: "Patek Philippe",
    model: "Calatrava",
    year: 2021,
    case_diameter: 39.0,
    case_thickness: 8.53,
    lug_width: 20.0,
    reference_number: "5227G-001",
    caliber: "324 S C",
    movement_type: "Automatic",
    features: "Officer-style caseback, Gyromax balance",
    complications: "None",
    description: "Classic dress watch with timeless design"
  },
  {
    brand: "Tudor",
    model: "Black Bay 58",
    year: 2020,
    case_diameter: 39.0,
    case_thickness: 11.9,
    lug_width: 20.0,
    reference_number: "79030N",
    caliber: "MT5402",
    movement_type: "Automatic",
    features: "Snowflake hands, Fabric strap",
    complications: "None",
    description: "Vintage-inspired dive watch with modern movement"
  }
]

watches_data.each do |watch_attrs|
  Watch.find_or_create_by(reference_number: watch_attrs[:reference_number]) do |watch|
    watch.assign_attributes(watch_attrs)
  end
end

puts "Created #{Watch.count} watches"
