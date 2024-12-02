import 'dart:io';

import 'package:tierlist/data/models/tier_item_image.dart';
import 'package:tierlist/data/models/tier_list.dart';
import 'package:tierlist/data/models/tier.dart';

class PopularTierLists {
  static List<TierList> get popularTierLists {
    final tierS = Tier(label: 'S');
    final tierA = Tier(label: 'A');
    final tierB = Tier(label: 'B');
    final tierC = Tier(label: 'C');
    final tierD = Tier(label: 'D');

    final items = [
      TierItemImage(
          id: 'burger',
          tier: tierS,
          imageFile: File('lib/data/sources/images/burger.jpg')),
      TierItemImage(
          id: 'pizza',
          tier: tierS,
          imageFile: File('lib/data/sources/images/pizza.jpg')),
      TierItemImage(
          id: 'tacos',
          tier: tierA,
          imageFile: File('lib/data/sources/images/tacos.jpg')),
      TierItemImage(
          id: 'fries',
          tier: tierA,
          imageFile: File('lib/data/sources/images/fries.jpg')),
      TierItemImage(
          id: 'chicken_nuggets',
          tier: tierA,
          imageFile: File('lib/data/sources/images/chicken_nuggets.jpg')),
      TierItemImage(
          id: 'hot_dog',
          tier: tierB,
          imageFile: File('lib/data/sources/images/hot_dog.jpg')),
      TierItemImage(
          id: 'onion_rings',
          tier: tierB,
          imageFile: File('lib/data/sources/images/onion_rings.jpg')),
      TierItemImage(
          id: 'milkshake',
          tier: tierB,
          imageFile: File('lib/data/sources/images/milkshake.jpg')),
      TierItemImage(
          id: 'sandwich',
          tier: tierB,
          imageFile: File('lib/data/sources/images/sandwich.jpg')),
      TierItemImage(
          id: 'wrap',
          tier: tierC,
          imageFile: File('lib/data/sources/images/wrap.jpg')),
      TierItemImage(
          id: 'kebab',
          tier: tierC,
          imageFile: File('lib/data/sources/images/kebab.jpg')),
      TierItemImage(
          id: 'salad',
          tier: tierB,
          imageFile: File('lib/data/sources/images/salad.jpg')),
      TierItemImage(
          id: 'sushi',
          tier: tierD,
          imageFile: File('lib/data/sources/images/sushi.jpg')),
      TierItemImage(
          id: 'burrito',
          tier: tierD,
          imageFile: File('lib/data/sources/images/burrito.jpg')),
      TierItemImage(
          id: 'pasta',
          tier: tierD,
          imageFile: File('lib/data/sources/images/pasta.jpg')),
      TierItemImage(
          id: 'tater_tots',
          tier: tierD,
          imageFile: File('lib/data/sources/images/tater_tots.jpg')),
      TierItemImage(
          id: 'nachos',
          tier: tierD,
          imageFile: File('lib/data/sources/images/nachos.jpg')),
      TierItemImage(
          id: 'chips',
          tier: tierD,
          imageFile: File('lib/data/sources/images/chips.jpg')),
      TierItemImage(
          id: 'mozzarella_sticks',
          tier: tierD,
          imageFile: File('lib/data/sources/images/mozzarella_sticks.jpg')),
      TierItemImage(
          id: 'cheesesteak',
          tier: tierD,
          imageFile: File('lib/data/sources/images/cheesesteak.jpg')),
      TierItemImage(
          id: 'corn_dog',
          tier: tierD,
          imageFile: File('lib/data/sources/images/corn_dog.jpg')),
    ];

    final fastFoodTierList = TierList(
      imagePath: "lib/data/sources/images/list_images/fastfood.png",
      id: 'fast_food_tier_list',
      name: 'Fast Food Tier List',
      tiers: [tierS, tierA, tierB, tierC, tierD],
      itemsMatrix: [
        [
          items[0],
          items[1],
        ],
        [
          items[2],
          items[3],
          items[4],
        ],
        [
          items[5],
          items[6],
          items[7],
          items[8],
          items[11],
        ],
        [
          items[9],
          items[10],
        ],
        [
          items[12],
          items[13],
          items[14],
          items[15],
          items[16],
          items[17],
          items[18],
          items[19],
        ],
      ],
      uncategorizedItems: [],
    );

    final sportsItems = [
      TierItemImage(
          id: 'soccer',
          tier: tierS,
          imageFile: File('lib/data/sources/images/soccer.jpg')),
      TierItemImage(
          id: 'basketball',
          tier: tierS,
          imageFile: File('lib/data/sources/images/basketball.jpg')),
      TierItemImage(
          id: 'tennis',
          tier: tierA,
          imageFile: File('lib/data/sources/images/tennis.jpg')),
      TierItemImage(
          id: 'baseball',
          tier: tierA,
          imageFile: File('lib/data/sources/images/baseball.jpg')),
      TierItemImage(
          id: 'cricket',
          tier: tierB,
          imageFile: File('lib/data/sources/images/cricket.jpg')),
      TierItemImage(
          id: 'hockey',
          tier: tierB,
          imageFile: File('lib/data/sources/images/hockey.jpg')),
      TierItemImage(
          id: 'golf',
          tier: tierC,
          imageFile: File('lib/data/sources/images/golf.jpg')),
      TierItemImage(
          id: 'swimming',
          tier: tierC,
          imageFile: File('lib/data/sources/images/swimming.jpg')),
      TierItemImage(
          id: 'boxing',
          tier: tierC,
          imageFile: File('lib/data/sources/images/boxing.jpg')),
      TierItemImage(
          id: 'rugby',
          tier: tierD,
          imageFile: File('lib/data/sources/images/rugby.jpg')),
      TierItemImage(
          id: 'cycling',
          tier: tierD,
          imageFile: File('lib/data/sources/images/cycling.jpg')),
      TierItemImage(
          id: 'badminton',
          tier: tierD,
          imageFile: File('lib/data/sources/images/badminton.jpg')),
      TierItemImage(
          id: 'table_tennis',
          tier: tierD,
          imageFile: File('lib/data/sources/images/table_tennis.jpg')),
      TierItemImage(
          id: 'skiing',
          tier: tierD,
          imageFile: File('lib/data/sources/images/skiing.jpg')),
      TierItemImage(
          id: 'snowboarding',
          tier: tierD,
          imageFile: File('lib/data/sources/images/snowboarding.jpg')),
    ];

    final sportsTierList = TierList(
      imagePath: "lib/data/sources/images/list_images/sports.png",
      id: 'sports_tier_list',
      name: 'Sports Tier List',
      tiers: [tierS, tierA, tierB, tierC, tierD],
      itemsMatrix: [
        [sportsItems[0], sportsItems[1]],
        [sportsItems[2], sportsItems[3]],
        [sportsItems[4], sportsItems[5]],
        [sportsItems[6], sportsItems[7], sportsItems[8]],
        [
          sportsItems[9],
          sportsItems[10],
          sportsItems[11],
          sportsItems[12],
          sportsItems[13],
          sportsItems[14]
        ],
      ],
      uncategorizedItems: [],
    );

    return [fastFoodTierList, sportsTierList];
  }
}
