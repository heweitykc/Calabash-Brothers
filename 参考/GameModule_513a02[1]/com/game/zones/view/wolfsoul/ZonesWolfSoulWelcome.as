package com.game.zones.view.wolfsoul
{
    import com.game.zones.control.*;
    import com.game.zones.view.base.*;

    public class ZonesWolfSoulWelcome extends ZonesBaseWelcome
    {

        public function ZonesWolfSoulWelcome()
        {
            loadDisplay("res/wolfsoulwelcome.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("wolf_welcome");
            super.displayReady();
            return;
        }// end function

        override protected function clickJoin() : void
        {
            ZonesControl.getInstance().openZonesWolfSoul();
            super.clickJoin();
            return;
        }// end function

    }
}
