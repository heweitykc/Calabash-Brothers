package com.game.remark.model
{

    public class RoleAttributes extends Object
    {
        public var remark:int;
        public var intenfisy:int;

        public function RoleAttributes()
        {
            return;
        }// end function

        public function prase(param1:String) : void
        {
            var _loc_2:* = param1.split(",");
            this.remark = _loc_2[0];
            this.intenfisy = _loc_2[1];
            return;
        }// end function

    }
}
