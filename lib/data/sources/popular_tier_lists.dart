import 'package:tierlist/app/utils/utils.dart';
import 'package:tierlist/data/models/tier_item_image.dart';
import 'package:tierlist/data/models/tier_item_text.dart';
import 'package:tierlist/data/models/tier_list.dart';
import 'package:tierlist/data/models/tier.dart';

class PopularTierLists {
  static Future<List<TierList>> get popularTierLists async {
    final tierS = Tier(label: 'S');
    final tierA = Tier(label: 'A');
    final tierB = Tier(label: 'B');
    final tierC = Tier(label: 'C');
    final tierD = Tier(label: 'D');
    final uncategorized = Tier(label: null);

    List<String> imageFiles = [
      'lib/data/sources/images/lists/food/food1.png',
      'lib/data/sources/images/lists/food/food2.png',
      'lib/data/sources/images/lists/food/food3.png',
      'lib/data/sources/images/lists/food/food4.png',
      'lib/data/sources/images/lists/food/food5.png',
      'lib/data/sources/images/lists/food/food6.png',
      'lib/data/sources/images/lists/food/food7.png',
      'lib/data/sources/images/lists/food/food8.png',
      'lib/data/sources/images/lists/food/food9.png',
      'lib/data/sources/images/lists/food/food10.png',
      'lib/data/sources/images/lists/food/food11.png',
      'lib/data/sources/images/lists/food/food12.png',
      'lib/data/sources/images/lists/food/food13.png',
      'lib/data/sources/images/lists/food/food14.png',
      'lib/data/sources/images/lists/places/place1.png',
      'lib/data/sources/images/lists/places/place2.png',
      'lib/data/sources/images/lists/places/place3.png',
      'lib/data/sources/images/lists/places/place4.png',
      'lib/data/sources/images/lists/places/place5.png',
      'lib/data/sources/images/lists/places/place6.png',
      'lib/data/sources/images/lists/places/place7.png',
      'lib/data/sources/images/lists/places/place8.png',
      'lib/data/sources/images/lists/places/place9.png',
      'lib/data/sources/images/lists/places/place10.png',
      'lib/data/sources/images/lists/places/place11.png',
      'lib/data/sources/images/lists/places/place12.png',
      'lib/data/sources/images/lists/sports/sport1.png',
      'lib/data/sources/images/lists/sports/sport2.png',
      'lib/data/sources/images/lists/sports/sport3.png',
      'lib/data/sources/images/lists/sports/sport4.png',
      'lib/data/sources/images/lists/sports/sport5.png',
      'lib/data/sources/images/lists/sports/sport6.png',
      'lib/data/sources/images/lists/sports/sport7.png',
      'lib/data/sources/images/lists/sports/sport8.png',
      'lib/data/sources/images/lists/sports/sport9.png',
      'lib/data/sources/images/lists/sports/sport10.png',
      'lib/data/sources/images/lists/sports/sport11.png',
      'lib/data/sources/images/lists/sports/sport12.png',
    ];
    final files = (await Utils.arePopularTierListImagesSaved(imageFiles[0]))
        ? await Utils.getPopularTierListImages(imageFiles)
        : await Utils.savePopularTierListImages(imageFiles);
    final filePaths = files.map((file) => file.path).toList();
    final movieGenresTierList = TierList(
      id: 'movie_genres',
      name: 'Movie Genres',
      imagePath: 'lib/data/sources/images/list_images/movies.png',
      tiers: [tierS, tierA, tierB, tierC, tierD],
      itemsMatrix: [
        [
          TierItemText(id: '1', tier: tierS, text: 'Action'),
          TierItemText(id: '2', tier: tierS, text: 'Science Fiction'),
        ],
        [
          TierItemText(id: '3', tier: tierA, text: 'Drama'),
          TierItemText(id: '4', tier: tierA, text: 'Thriller'),
          TierItemText(id: '14', tier: tierB, text: 'Biographical'),
        ],
        [
          TierItemText(id: '5', tier: tierB, text: 'Comedy'),
          TierItemText(id: '6', tier: tierB, text: 'Fantasy'),
          TierItemText(id: '13', tier: tierC, text: 'Mystery'),
        ],
        [
          TierItemText(id: '7', tier: tierC, text: 'Horror'),
          TierItemText(id: '8', tier: tierC, text: 'Romance'),
          TierItemText(id: '15', tier: tierA, text: 'Adventure'),
        ],
        [
          TierItemText(id: '9', tier: tierD, text: 'Documentary'),
          TierItemText(id: '10', tier: tierD, text: 'Musical'),
        ],
      ],
      uncategorizedItems: [
        TierItemText(id: '11', tier: uncategorized, text: 'Western'),
        TierItemText(id: '12', tier: uncategorized, text: 'Animation'),
        TierItemText(id: '16', tier: uncategorized, text: 'Superhero'),
      ],
    );

    final techTierList = TierList(
      id: 'tech_trends',
      name: 'Tech Trends',
      tiers: [tierS, tierA, tierB, tierC, tierD],
      itemsMatrix: [
        [
          TierItemText(id: 'ai', tier: tierS, text: 'AI'),
          TierItemText(
              id: 'quantum_computing', tier: tierS, text: 'Quantum Computing'),
          TierItemText(id: '5g', tier: tierS, text: '5G Technology'),
        ],
        [
          TierItemText(id: 'ar', tier: tierA, text: 'AR'),
          TierItemText(id: 'vr', tier: tierA, text: 'VR'),
          TierItemText(id: 'blockchain', tier: tierA, text: 'Blockchain'),
          TierItemText(id: 'cloud_gaming', tier: tierA, text: 'Cloud Gaming'),
          TierItemText(id: 'smart_cities', tier: tierA, text: 'Smart Cities'),
        ],
        [
          TierItemText(id: '3d_printing', tier: tierB, text: '3D Printing'),
          TierItemText(id: 'digital_twins', tier: tierB, text: 'Digital Twins'),
          TierItemText(id: 'drones', tier: tierB, text: 'Drones'),
          TierItemText(id: 'robotics', tier: tierB, text: 'Robotics'),
        ],
        [
          TierItemText(id: 'iot', tier: tierB, text: 'IoT'),
        ],
        [
          TierItemText(id: 'console_games', tier: tierD, text: 'Console Games'),
          TierItemText(id: 'cybersecurity', tier: tierD, text: 'Cybersecurity'),
        ],
      ],
      uncategorizedItems: [
        TierItemText(id: 'metaverse', tier: uncategorized, text: 'Metaverse'),
        TierItemText(
            id: 'mobile_games', tier: uncategorized, text: 'Mobile Games'),
      ],
      imagePath: 'lib/data/sources/images/list_images/tech.png',
    );

    final jobsTierList = TierList(
      id: 'jobs',
      name: 'Jobs',
      tiers: [tierS, tierA, tierB, tierC, tierD],
      itemsMatrix: [
        [
          TierItemText(
              id: 'software_engineer', tier: tierS, text: 'Software Engineer'),
          TierItemText(
              id: 'data_scientist', tier: tierS, text: 'Data Scientist'),
          TierItemText(id: 'doctor', tier: tierS, text: 'Doctor'),
        ],
        [
          TierItemText(
              id: 'investment_banker', tier: tierA, text: 'Investment Banker'),
          TierItemText(
              id: 'marketing_director',
              tier: tierA,
              text: 'Marketing Director'),
          TierItemText(id: 'lawyer', tier: tierA, text: 'Lawyer'),
          TierItemText(
              id: 'police_officer', tier: tierA, text: 'Police Officer'),
        ],
        [
          TierItemText(id: 'nurse', tier: tierB, text: 'Nurse'),
          TierItemText(id: 'accountant', tier: tierB, text: 'Accountant'),
          TierItemText(
              id: 'graphic_designer', tier: tierB, text: 'Graphic Designer'),
          TierItemText(id: 'architect', tier: tierB, text: 'Architect'),
        ],
        [
          TierItemText(id: 'web_developer', tier: tierC, text: 'Web Developer'),
          TierItemText(id: 'hr_manager', tier: tierB, text: 'HR Manager'),
        ],
        [
          TierItemText(id: 'travel_agent', tier: tierD, text: 'Travel Agent'),
          TierItemText(id: 'teacher', tier: tierB, text: 'Teacher'),
        ],
      ],
      uncategorizedItems: [
        TierItemText(id: 'influencer', tier: uncategorized, text: 'Influencer'),
        TierItemText(
            id: 'professional_gamer',
            tier: uncategorized,
            text: 'Professional Gamer'),
      ],
      imagePath: 'lib/data/sources/images/list_images/jobs.png',
    );

    final fashionTierList = TierList(
      id: 'fashion_trends',
      name: 'Fashion Trends',
      tiers: [tierS, tierA, tierB, tierC, tierD],
      itemsMatrix: [
        [
          TierItemText(id: 'streetwear', tier: tierS, text: 'Streetwear'),
          TierItemText(
              id: 'vintage_clothing', tier: tierS, text: 'Vintage Clothing'),
          TierItemText(id: 'opium', tier: tierS, text: 'Opium'),
        ],
        [
          TierItemText(
              id: 'monochrome_outfits',
              tier: tierA,
              text: 'Monochrome Outfits'),
          TierItemText(
              id: 'tailoring_suits', tier: tierA, text: 'Tailoring Suits'),
        ],
        [
          TierItemText(
              id: 'oversized_clothing',
              tier: tierB,
              text: 'Oversized Clothing'),
          TierItemText(
              id: 'puffer_jackets', tier: tierB, text: 'Puffer Jackets'),
          TierItemText(
              id: 'leather_jackets', tier: tierB, text: 'Leather Jackets'),
        ],
        [
          TierItemText(id: 'punk_fashion', tier: tierC, text: 'Punk Fashion'),
          TierItemText(
              id: 'chunky_sneakers', tier: tierB, text: 'Chunky Sneakers'),
        ],
        [
          TierItemText(id: 'fast_fashion', tier: tierD, text: 'Fast Fashion'),
          TierItemText(id: 'minimalism', tier: tierA, text: 'Minimalism'),
        ],
      ],
      uncategorizedItems: [
        TierItemText(id: 'techwear', tier: uncategorized, text: 'Techwear'),
        TierItemText(id: 'athleisure', tier: uncategorized, text: 'Athleisure'),
      ],
      imagePath: 'lib/data/sources/images/list_images/fashion.png',
    );

    final musicTierList = TierList(
      id: 'music',
      name: 'Music Genres',
      tiers: [tierS, tierA, tierB, tierC, tierD],
      itemsMatrix: [
        [
          TierItemText(id: 'rock', tier: tierS, text: 'Rock'),
          TierItemText(id: 'pop', tier: tierS, text: 'Pop'),
          TierItemText(id: 'hiphop_rap', tier: tierS, text: 'Hip-Hop/Rap'),
        ],
        [
          TierItemText(id: 'rnb', tier: tierA, text: 'R&B'),
          TierItemText(id: 'punk_rock', tier: tierA, text: 'Punk Rock'),
        ],
        [
          TierItemText(id: 'metal', tier: tierB, text: 'Metal'),
          TierItemText(id: 'techno', tier: tierB, text: 'Techno'),
          TierItemText(id: 'trap', tier: tierB, text: 'Trap'),
        ],
        [
          TierItemText(id: 'ambient', tier: tierC, text: 'Ambient'),
          TierItemText(id: 'classical', tier: tierS, text: 'Classical'),
        ],
        [
          TierItemText(id: 'kpop', tier: tierD, text: 'K-Pop'),
          TierItemText(id: 'jazz', tier: tierS, text: 'Jazz'),
        ],
      ],
      uncategorizedItems: [
        TierItemText(id: 'country', tier: uncategorized, text: 'Country'),
        TierItemText(id: 'edm', tier: uncategorized, text: 'EDM'),
      ],
      imagePath: 'lib/data/sources/images/list_images/music.png',
    );

    final foodTierList = TierList(
      id: 'food',
      name: 'Food',
      tiers: [tierS, tierA, tierB, tierC, tierD],
      itemsMatrix: [
        [
          TierItemImage(id: 'food1', tier: tierS, imageFile: filePaths[0]),
          TierItemImage(id: 'food2', tier: tierS, imageFile: filePaths[1]),
          TierItemImage(id: 'food3', tier: tierS, imageFile: filePaths[2]),
        ],
        [
          TierItemImage(id: 'food4', tier: tierA, imageFile: filePaths[3]),
          TierItemImage(id: 'food5', tier: tierA, imageFile: filePaths[4]),
          TierItemImage(id: 'food6', tier: tierA, imageFile: filePaths[5]),
        ],
        [
          TierItemImage(id: 'food8', tier: tierB, imageFile: filePaths[7]),
          TierItemImage(id: 'food9', tier: tierB, imageFile: filePaths[8]),
        ],
        [
          TierItemImage(id: 'food10', tier: tierC, imageFile: filePaths[9]),
          TierItemImage(id: 'food11', tier: tierC, imageFile: filePaths[10]),
        ],
        [
          TierItemImage(id: 'food12', tier: tierD, imageFile: filePaths[11]),
          TierItemImage(id: 'food13', tier: tierD, imageFile: filePaths[12]),
        ],
      ],
      uncategorizedItems: [
        TierItemImage(
            id: 'food14', tier: uncategorized, imageFile: filePaths[13]),
        TierItemImage(
            id: 'food7', tier: uncategorized, imageFile: filePaths[6]),
      ],
      imagePath: 'lib/data/sources/images/list_images/food.png',
    );

    final destinationsTierList = TierList(
      id: 'places',
      name: 'Destinations',
      tiers: [tierS, tierA, tierB, tierC, tierD],
      itemsMatrix: [
        [
          TierItemImage(id: 'place1', tier: tierS, imageFile: filePaths[14]),
          TierItemImage(id: 'place2', tier: tierS, imageFile: filePaths[15]),
        ],
        [
          TierItemImage(id: 'place3', tier: tierA, imageFile: filePaths[16]),
          TierItemImage(id: 'place4', tier: tierA, imageFile: filePaths[17]),
        ],
        [
          TierItemImage(id: 'place5', tier: tierB, imageFile: filePaths[18]),
          TierItemImage(id: 'place6', tier: tierB, imageFile: filePaths[19]),
        ],
        [
          TierItemImage(id: 'place7', tier: tierC, imageFile: filePaths[20]),
          TierItemImage(id: 'place8', tier: tierC, imageFile: filePaths[21]),
        ],
        [
          TierItemImage(id: 'place9', tier: tierD, imageFile: filePaths[22]),
          TierItemImage(id: 'place10', tier: tierD, imageFile: filePaths[23]),
        ],
      ],
      uncategorizedItems: [
        TierItemImage(
            id: 'place11', tier: uncategorized, imageFile: filePaths[24]),
        TierItemImage(
            id: 'place12', tier: uncategorized, imageFile: filePaths[25]),
      ],
      imagePath: 'lib/data/sources/images/list_images/places.png',
    );

    final sportsTierList = TierList(
      id: 'sports',
      name: 'Sports',
      tiers: [tierS, tierA, tierB, tierC, tierD],
      itemsMatrix: [
        [
          TierItemImage(id: 'sport1', tier: tierS, imageFile: filePaths[26]),
          TierItemImage(id: 'sport2', tier: tierS, imageFile: filePaths[27]),
        ],
        [
          TierItemImage(id: 'sport3', tier: tierA, imageFile: filePaths[28]),
          TierItemImage(id: 'sport4', tier: tierA, imageFile: filePaths[29]),
        ],
        [
          TierItemImage(id: 'sport5', tier: tierB, imageFile: filePaths[30]),
          TierItemImage(id: 'sport6', tier: tierB, imageFile: filePaths[31]),
        ],
        [
          TierItemImage(id: 'sport7', tier: tierC, imageFile: filePaths[32]),
          TierItemImage(id: 'sport8', tier: tierC, imageFile: filePaths[33]),
        ],
        [
          TierItemImage(id: 'sport9', tier: tierD, imageFile: filePaths[34]),
          TierItemImage(id: 'sport10', tier: tierD, imageFile: filePaths[35]),
        ],
      ],
      uncategorizedItems: [
        TierItemImage(
            id: 'sport11', tier: uncategorized, imageFile: filePaths[36]),
        TierItemImage(
            id: 'sport12', tier: uncategorized, imageFile: filePaths[37]),
      ],
      imagePath: 'lib/data/sources/images/list_images/sports.png',
    );

    return [
      foodTierList,
      movieGenresTierList,
      sportsTierList,
      destinationsTierList,
      techTierList,
      jobsTierList,
      fashionTierList,
      musicTierList
    ];
  }
}
