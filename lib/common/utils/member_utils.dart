
enum MembershipType {solitaire, platinum, gold, silver, amethyst, nonMember}

class MemberUtils{

  static const solitaireId = '38c2cd71-8dbd-4911-a1c0-f24869ebb02f';
  static const platinumId = '8ed41640-2a89-4a0c-9553-12561ff69eb0';
  static const goldId = '18e6a4b1-c609-460f-a796-c9e1661c5eff';
  static const silverId = '5557d9dd-53ff-499d-a037-c8881d9da732';
  static const amethystId = '91e5aae1-6edd-4394-a648-5908084db3e7';

  static MembershipType getMembershipTypeById(String? id){
    switch(id){
      case solitaireId:
        return MembershipType.solitaire;

      case platinumId:
        return MembershipType.platinum;

      case goldId:
        return MembershipType.gold;

      case silverId:
        return MembershipType.silver;

      case amethystId:
        return MembershipType.amethyst;

      default:
        return MembershipType.nonMember;
    }
  }

  static MembershipType getMembershipTypeByName(String? name){
    final lowerName = name?.toLowerCase();
    switch(lowerName){
      case 'solitaire':
        return MembershipType.solitaire;

      case 'platinum':
        return MembershipType.platinum;

      case 'gold':
        return MembershipType.gold;

      case 'silver':
        return MembershipType.silver;

      case 'amethyst':
        return MembershipType.amethyst;

      default:
        return MembershipType.nonMember;
    }
  }


  static String? loyaltyCard(MembershipType userType){
    switch(userType){
      case MembershipType.gold:
        return "assets/images/placeholders/loyalty_points/loyalty_gold.png";
      case MembershipType.solitaire:
        return "assets/images/placeholders/loyalty_points/loyalty_solitaire.png";
      case MembershipType.silver:
        return "assets/images/placeholders/loyalty_points/loytalty_silver.png";
      case MembershipType.platinum:
        return "assets/images/placeholders/loyalty_points/loyalty_platinium.png";
      case MembershipType.amethyst:
        return "assets/images/placeholders/loyalty_points/loyalty_amethyst.png";
      case MembershipType.nonMember:
        return null;
    }
  }

  static String? getMembershipCircle(MembershipType userType){
    switch(userType){
      case MembershipType.solitaire:
        return 'assets/images/membership_circles/solitaire_circle.png';

      case MembershipType.platinum:
        return 'assets/images/membership_circles/platinum_circle.png';

      case MembershipType.gold:
        return 'assets/images/membership_circles/gold_circle.png';

      case MembershipType.silver:
        return 'assets/images/membership_circles/silver_circle.png';

      case MembershipType.amethyst:
        return 'assets/images/membership_circles/amethyst_circle.png';

      default:
        return null;
    }
  }

}