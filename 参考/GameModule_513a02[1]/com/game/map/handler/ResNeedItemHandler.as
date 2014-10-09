package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import com.staticdata.*;
    import net.*;

    public class ResNeedItemHandler extends Handler
    {

        public function ResNeedItemHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResNeedItemMessage(this.message);
            switch(_loc_1.type)
            {
                case 1:
                {
                    MapControl.getInstance().canSkyCityIn(Params.SKY_CITY_MAP);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
