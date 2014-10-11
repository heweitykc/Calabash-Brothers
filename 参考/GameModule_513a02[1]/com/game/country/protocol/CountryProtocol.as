package com.game.country.protocol
{
    import com.*;
    import com.game.country.message.*;

    public class CountryProtocol extends BaseProtocol
    {

        public function CountryProtocol()
        {
            return;
        }// end function

        public function resCountrySiegeSelect(param1:int) : void
        {
            var _loc_2:* = new ResCountrySiegeSelectToGameMessage();
            _loc_2.type = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqCountryOpenTop() : void
        {
            var _loc_1:* = new ReqCountryOpenTopToGameMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqCountrysalary() : void
        {
            var _loc_1:* = new ReqCountrysalaryToGameMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqCountryCaptureSalary(param1:int) : void
        {
            var _loc_2:* = new ReqGetAngleMessage();
            _loc_2.count = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqCountryStructureInfo() : void
        {
            var _loc_1:* = new ReqCountryStructureInfoToGameMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqKingCityChestSelect(param1:int) : void
        {
            var _loc_2:* = new ReqKingCityChestSelectToGameMessage();
            _loc_2.idx = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqCJinYan(param1:String) : void
        {
            var _loc_2:* = new ReqCJinYanMessage();
            _loc_2.playername = param1;
            send(_loc_2);
            return;
        }// end function

        public function reqSiegeMoveMap() : void
        {
            var _loc_1:* = new ReqSiegeMoveMapMessage();
            send(_loc_1);
            return;
        }// end function

        public function reqAddCountryBuff() : void
        {
            var _loc_1:* = new ReqAddCountryBuffMessage();
            send(_loc_1);
            return;
        }// end function

    }
}
