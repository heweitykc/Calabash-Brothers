package com.game.xscb.view
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.zones.control.*;
    import com.game.zones.view.base.*;
    import com.greensock.*;
    import com.model.*;
    import flash.events.*;

    public class ZonesScarletHoldPanel extends ZonesBasePanel implements IGuide
    {
        private static const HIT_CLEARCD:String = LanguageCfgObj.getInstance().getByIndex("11453");

        public function ZonesScarletHoldPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            super(param1, param2, param3, param4);
            return;
        }// end function

        override public function open() : void
        {
            var _loc_1:* = UserObj.getInstance().playerInfo.level;
            if (_loc_1 < 15)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11454"));
                return;
            }
            super.open();
            this._zoneTableInfo = ZonesCloneCfg.getInstance().getCurZones(_loc_1, 2);
            if (this._zoneTableInfo)
            {
                ZonesControl.getInstance().reqZoneTeamOpenToGame(this._zoneTableInfo.id);
            }
            if (UILoaded)
            {
                _propaganda.gotoAndStop(2);
            }
            this.registerGuide();
            return;
        }// end function

        override protected function initUI() : void
        {
            super.initUI();
            _propaganda.gotoAndStop(2);
            _txtTile.gotoAndStop(2);
            return;
        }// end function

        override protected function cleanZonesCD() : void
        {
            super.cleanZonesCD();
            var _loc_1:* = this._cdEnter.count / 1000;
            if (_loc_1 <= 0)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11455"));
                return;
            }
            var _loc_2:* = Math.floor(this._cdEnter.count / (1000 * 30));
            var _loc_3:* = HIT_CLEARCD.replace("#", _loc_2.toString());
            Global.popManager.cue(_loc_3, "", null, this.callCleanCD);
            return;
        }// end function

        override protected function enterZones() : void
        {
            super.enterZones();
            return;
        }// end function

        override protected function enterTeamZones() : void
        {
            super.enterTeamZones();
            return;
        }// end function

        private function callCleanCD() : void
        {
            ZonesControl.getInstance().reqclearZoneCD(this.zoneServerInfo.zoneid);
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this.guidePause(GuideConfigObj.getInstance().XSCB_ZONE_GUIDE_ID_2);
            this.guidePause(GuideConfigObj.getInstance().FIRST_OPEN_XS_1);
            TweenLite.killDelayedCallsTo(this.delayEnter);
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.displayReady();
            this.registerGuide();
            var _loc_1:* = int(GuideConfigObj.getInstance().FIRST_OPEN_XS);
            if (GuideConfigObj.getInstance().getGuideConfig(_loc_1) == 0)
            {
                GuideMultiControl.getInstance().beginGuide(_loc_1);
                GuideConfigObj.getInstance().saveConfigByTeam(_loc_1, 1);
                TweenLite.delayedCall(15, this.delayEnter);
            }
            return;
        }// end function

        private function delayEnter() : void
        {
            _btnEnter.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            return;
        }// end function

        public function registerGuide() : void
        {
            if (!UILoaded)
            {
                return;
            }
            GuideControl.getInstance().registerGuide(_btnEnter, this, GuideConfigObj.getInstance().XSCB_ZONE_GUIDE_ID_2);
            GuideMultiControl.getInstance().registerGuide(_btnEnter, this, GuideConfigObj.getInstance().FIRST_OPEN_XS_1);
            GuideMultiControl.getInstance().unHideGuide(GuideConfigObj.getInstance().FIRST_OPEN_XS_1);
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            if (param1 == GuideConfigObj.getInstance().XSCB_ZONE_GUIDE_ID_2)
            {
                GuideControl.getInstance().backGuide(param1, 1);
            }
            if (param1 == GuideConfigObj.getInstance().FIRST_OPEN_XS_1)
            {
                GuideMultiControl.getInstance().hideGuide(GuideConfigObj.getInstance().FIRST_OPEN_XS_1);
            }
            return;
        }// end function

        public function guideEnd(param1:String) : void
        {
            return;
        }// end function

        public function isGuideReady() : Boolean
        {
            return true;
        }// end function

    }
}
