package com.game.prey.view
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.goldRaffle.view.component.*;
    import flash.display.*;

    public class PrayBoxTitle extends BaseSprite
    {
        private var titlePart1:DisplayObject;
        private var titlePart3:DisplayObject;
        private var number:NumberMc;
        public static const JIN_BI:String = "jinbi";
        public static const JIN_YAN:String = "jingyan";

        public function PrayBoxTitle(param1:String = "jinbi")
        {
            this.titlePart1 = ToolKit.getNewDO("pray_title1");
            this.titlePart3 = ToolKit.getNewDO("pray_" + param1);
            this.number = new NumberMc("pray_num");
            this.number.interX = -3;
            addChild(this.titlePart1);
            addChild(this.number);
            addChild(this.titlePart3);
            this.value = 0;
            return;
        }// end function

        public function set value(param1:int) : void
        {
            var _loc_2:* = NaN;
            this.number.setNumber(param1);
            _loc_2 = (-(this.titlePart3.width + this.titlePart1.width + this.number.width)) / 2;
            this.titlePart1.x = _loc_2;
            this.number.x = _loc_2 + this.titlePart1.width;
            this.titlePart3.x = _loc_2 + this.titlePart1.width + this.number.width;
            return;
        }// end function

    }
}
