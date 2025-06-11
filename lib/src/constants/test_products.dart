import '../features/products/domain/product.dart';

/// Test products to be used until a data source is implemented
const kTestProducts = [
  Product(
    id: '1',
    imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349',
    title: 'Cheeseburger',
    description: 'Classic grilled cheeseburger with lettuce and tomato.',
    price: 12.99,
    availableQuantity: 30,
    avgRating: 4.3,
    numRatings: 34,
  ),
  Product(
    id: '2',
    imageUrl:
        'https://cdn.shopify.com/s/files/1/0274/9503/9079/files/20220211142754-margherita-9920_5a73220e-4a1a-4d33-b38f-26e98e3cd986.jpg?v=1723650067',
    title: 'Margherita Pizza',
    description: 'Classic pizza with mozzarella and fresh basil.',
    price: 14.50,
    availableQuantity: 25,
    avgRating: 4.6,
    numRatings: 52,
  ),
  Product(
    id: '3',
    imageUrl:
        'https://cdn.simpele-recepten.nl/wp-content/uploads/2024/04/Pizza-pepperoni.webp',
    title: 'Pepperoni Pizza',
    description: 'Loaded pepperoni on a cheesy crust.',
    price: 15.00,
    availableQuantity: 40,
    avgRating: 4.7,
    numRatings: 45,
  ),
  Product(
    id: '4',
    imageUrl:
        'https://static01.nyt.com/images/2021/02/14/dining/carbonara-horizontal/carbonara-horizontal-threeByTwoMediumAt2X-v2.jpg',
    title: 'Pasta Carbonara',
    description: 'Creamy pasta with pancetta and parmesan.',
    price: 13.75,
    availableQuantity: 22,
    avgRating: 4.2,
    numRatings: 29,
  ),
  Product(
    id: '5',
    imageUrl:
        'https://www.southernliving.com/thmb/sQ3jAjFAP-SPt_upe-Im4rxMKrQ=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/oven-baked-baby-back-ribs-beauty-332_preview-34579f7f15ed4548ae3bb5b2048aab60.jpg',
    title: 'BBQ Ribs',
    description: 'Slow-cooked BBQ pork ribs with tangy sauce.',
    price: 18.99,
    availableQuantity: 15,
    avgRating: 4.8,
    numRatings: 60,
  ),
  Product(
    id: '6',
    imageUrl:
        'https://www.crunchycreamysweet.com/wp-content/uploads/2018/06/easy-grilled-chicken-salad-1.jpg',
    title: 'Grilled Chicken Salad',
    description: 'Fresh greens with grilled chicken and vinaigrette.',
    price: 11.00,
    availableQuantity: 35,
    avgRating: 4.1,
    numRatings: 18,
  ),
  Product(
    id: '7',
    imageUrl:
        'https://www.francoislambert.one/cdn/shop/articles/fish_and_chips.jpg?v=1728066282',
    title: 'Fish and Chips',
    description: 'Crispy battered fish with golden fries.',
    price: 14.20,
    availableQuantity: 20,
    avgRating: 4.5,
    numRatings: 26,
  ),
  Product(
    id: '8',
    imageUrl:
        'https://beeflovingtexans.com/wp-content/uploads/2023/09/Recipe_Chimichurri_Steak_Sandwich_UBLT.jpeg',
    title: 'Steak Sandwich',
    description: 'Sliced steak in a toasted bun with onions.',
    price: 16.00,
    availableQuantity: 18,
    avgRating: 4.4,
    numRatings: 33,
  ),
  Product(
    id: '9',
    imageUrl:
        'https://www.thespruceeats.com/thmb/FSvSeBUSzDD0Wa6-TiXYDLFZx5c=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/vegetarian-wraps-88177231-5abc4a71119fa80037df58f8.jpg',
    title: 'Vegan Wrap',
    description: 'Healthy wrap with hummus and fresh veggies.',
    price: 9.99,
    availableQuantity: 50,
    avgRating: 4.0,
    numRatings: 10,
  ),
  Product(
    id: '10',
    imageUrl:
        'https://www.thespruceeats.com/thmb/gTjo1gnOuBEVJsttgDW2JljvKY0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/shrimp-fettuccine-alfredo-recipe-5205738-hero-01-1a40571b0e3e4a17ab768b4d700c7836.jpg',
    title: 'Fettuccine Alfredo',
    description: 'Rich creamy sauce over fettuccine noodles.',
    price: 13.25,
    availableQuantity: 28,
    avgRating: 4.6,
    numRatings: 21,
  ),
  Product(
    id: '11',
    imageUrl:
        'https://natashaskitchen.com/wp-content/uploads/2022/02/Buffalo-Wings-SQ.jpg',
    title: 'Buffalo Wings',
    description: 'Spicy wings with a side of ranch.',
    price: 12.50,
    availableQuantity: 45,
    avgRating: 4.3,
    numRatings: 37,
  ),
  Product(
    id: '12',
    imageUrl:
        'https://www.allrecipes.com/thmb/qX33KNwobIQ742FAouPjBbsgH4U=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/21659-Chicken-Quesadillas-DDMFS-3291-4x3-Beauty-8849a09057d34cde9bad913783262833.jpg',
    title: 'Chicken Quesadilla',
    description: 'Grilled tortilla filled with cheese and chicken.',
    price: 10.99,
    availableQuantity: 40,
    avgRating: 4.2,
    numRatings: 24,
  ),
  Product(
    id: '13',
    imageUrl:
        'https://pinchofyum.com/wp-content/uploads/Shrimp-Tacos-with-Slaw.jpg',
    title: 'Shrimp Tacos',
    description: 'Tacos filled with spicy shrimp and fresh toppings.',
    price: 13.99,
    availableQuantity: 17,
    avgRating: 4.7,
    numRatings: 19,
  ),
  Product(
    id: '14',
    imageUrl:
        'https://static1.squarespace.com/static/62227f3fe1583d580047c391/623dc6e8e9400537fbbcaa9e/628fd581f695f7268e821751/1682108036492/ACM01078.jpg?format=1500w',
    title: 'Stuffed Crust Pizza',
    description: 'Cheesy crust pizza with extra toppings.',
    price: 17.50,
    availableQuantity: 12,
    avgRating: 4.9,
    numRatings: 48,
  ),
  Product(
    id: '15',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5SHOkiA0um5tZ3V23l-zXN6WJzKNW-01AWw&s',
    title: 'Mac and Cheese',
    description: 'Creamy cheesy pasta baked to perfection.',
    price: 10.50,
    availableQuantity: 38,
    avgRating: 4.4,
    numRatings: 27,
  ),
];
