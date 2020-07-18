
class Owner {

   String ownName;
   String ownNic;
   String ownAddress;


    String get own_name{
      return ownName;
    }

    void set own_name(String ownName){
      this.ownName = ownName;
    }

      String get own_nic{
      return ownNic;
    }

    void set own_nic(String ownNic){
      this.ownNic = ownNic;
    }

      String get own_address{
      return ownAddress;
    }

    void set own_address(String ownAddress){
      this.ownAddress = ownAddress;
    }

    Owner(String ownName,String ownNic,String ownAddress){
      this.ownName = ownName;
      this.ownNic = ownNic;
      this.ownAddress = ownAddress;
      print(ownName);
    }
}