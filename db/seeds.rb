# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tabletops = Tabletop.create([
  {
	"seats":"2",
	"table_name":"TableOne"
  },
  {
	"seats":"2",
	"table_name":"TableTwo"
  },
  {
	"seats":"2",
	"table_name":"TableThree"
  },
  {
	"seats":"4",
	"table_name":"TableFour"
  },
  {
	"seats":"4",
	"table_name":"TableFive"
  },
  {
	"seats":"4",
	"table_name":"TableSix"
  },
  {
	"seats":"6",
	"table_name":"TableSeven"
  },
  {
	"seats":"6",
	"table_name":"TableEight"
  },
  {
	"seats":"8",
	"table_name":"TableNine"
  },
  {
	"seats":"8",
	"table_name":"TableTen"
  },
])
