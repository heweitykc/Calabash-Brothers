package com.game.guide.consts
{
    import com.staticdata.*;

    public class FunGuideConst extends Object
    {
        public static const PRAY:int = 1;
        public static const SCARLETHOLD:int = 2;
        public static const BELIAWORLD:int = 3;
        public static const BOSSGUIDE:int = 4;
        public static const STALLS:int = 5;
        public static const MALL:int = 6;
        public static const GOLD:int = 1;
        public static const BLESS:int = 2;
        public static const SOUL:int = 3;
        public static const LIFE:int = 4;
        public static const RIDE:int = 5;
        public static const SUPER_RIDE:int = 6;

        public function FunGuideConst()
        {
            return;
        }// end function

        public static function getIconByType(param1:int) : String
        {
            var _loc_2:* = "";
            switch(param1)
            {
                case PRAY:
                {
                    _loc_2 = Params.ART_PATH + "icon/i10131.png";
                    break;
                }
                case SCARLETHOLD:
                {
                    _loc_2 = Params.ART_PATH + "icon/i10127.png";
                    break;
                }
                case BELIAWORLD:
                {
                    _loc_2 = Params.ART_PATH + "icon/i10128.png";
                    break;
                }
                case BOSSGUIDE:
                {
                    _loc_2 = Params.ART_PATH + "icon/i10136.png";
                    break;
                }
                case STALLS:
                {
                    _loc_2 = Params.ART_PATH + "icon/i10137.png";
                    break;
                }
                case MALL:
                {
                    _loc_2 = Params.ART_PATH + "icon/i10138.png";
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
