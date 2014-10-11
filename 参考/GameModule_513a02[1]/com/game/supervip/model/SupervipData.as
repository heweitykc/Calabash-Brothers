package com.game.supervip.model
{
    import com.game.supervip.event.*;
    import com.game.supervip.message.*;
    import flash.events.*;

    public class SupervipData extends EventDispatcher
    {
        public var hasData:Boolean = false;
        public var gmName:String;
        public var gmQq:String;
        public var gmPhoto:String;
        public var curRmb:int;
        public var requiredRmb:int;
        private static var instance:SupervipData;

        public function SupervipData()
        {
            return;
        }// end function

        public function get rmbDif() : int
        {
            return this.curRmb >= this.requiredRmb ? (0) : (this.requiredRmb - this.curRmb);
        }// end function

        public function updateData(param1:ResGetSuperVipInfoMessage) : void
        {
            this.hasData = true;
            this.gmName = param1.name;
            this.gmQq = param1.qq;
            this.gmPhoto = param1.pic;
            this.curRmb = param1.recharge;
            this.requiredRmb = param1.limit;
            dispatchEvent(new SupervipEvent(SupervipEvent.SUPERVIP_DATA_CHANGE));
            return;
        }// end function

        public static function getInstance() : SupervipData
        {
            var _loc_1:* = new SupervipData;
            instance = new SupervipData;
            return instance || _loc_1;
        }// end function

    }
}
