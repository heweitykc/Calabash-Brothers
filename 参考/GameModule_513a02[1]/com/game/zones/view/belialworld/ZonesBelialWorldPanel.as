package com.game.zones.view.belialworld
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.zones.control.*;
    import com.game.zones.view.base.*;
    import com.model.*;

    public class ZonesBelialWorldPanel extends ZonesBasePanel implements IGuide
    {
        private static var HIT_CLEARCD:String = LanguageCfgObj.getInstance().getByIndex("11525");
        public static const TYPE_TEAM_ZONE:String = "type_team_zone";
        public static const TYPE_ZONE:String = "type_zone";

        public function ZonesBelialWorldPanel()
        {
            return;
        }// end function

        override protected function initUI() : void
        {
            super.initUI();
            _txtTile.gotoAndStop(1);
            _propaganda.gotoAndStop(1);
            this.registerGuide();
            var _loc_1:* = int(GuideConfigObj.getInstance().FIRST_OPEN_BELIA_WORLD);
            if (GuideConfigObj.getInstance().getGuideConfig(_loc_1) == 0)
            {
                GuideMultiControl.getInstance().beginGuide(_loc_1);
                GuideConfigObj.getInstance().saveConfigByTeam(_loc_1, 1);
            }
            return;
        }// end function

        override protected function cleanZonesCD() : void
        {
            super.cleanZonesCD();
            var _loc_1:* = this._cdEnter.count / 1000;
            if (_loc_1 <= 0)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11497"));
                return;
            }
            var _loc_2:* = Math.floor(this._cdEnter.count / (1000 * 30));
            var _loc_3:* = HIT_CLEARCD.replace("#", _loc_2.toString());
            Global.popManager.cue(_loc_3, "", null, this.callCleanCD);
            return;
        }// end function

        private function callCleanCD() : void
        {
            ZonesControl.getInstance().reqclearZoneCD(this.zoneServerInfo.zoneid);
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
            _propaganda.gotoAndStop(1);
            return;
        }// end function

        override public function open() : void
        {
            var _loc_1:* = UserObj.getInstance().playerInfo.level;
            if (_loc_1 < 15)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11498"));
                return;
            }
            super.open();
            this._zoneTableInfo = ZonesCloneCfg.getInstance().getCurZones(_loc_1, 1);
            if (this._zoneTableInfo)
            {
                ZonesControl.getInstance().reqZoneTeamOpenToGame(this._zoneTableInfo.id);
            }
            this.registerGuide();
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this.guidePause(GuideConfigObj.getInstance().FIRST_OPEN_BELIA_WORLD_1);
            return;
        }// end function

        override protected function setTips() : void
        {
            return;
        }// end function

        public function registerGuide() : void
        {
            if (!UILoaded)
            {
                return;
            }
            GuideMultiControl.getInstance().registerGuide(_btnEnter, this, GuideConfigObj.getInstance().FIRST_OPEN_BELIA_WORLD_1);
            GuideMultiControl.getInstance().unHideGuide(GuideConfigObj.getInstance().FIRST_OPEN_BELIA_WORLD_1);
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            GuideMultiControl.getInstance().hideGuide(param1);
            return;
        }// end function

        public function guideEnd(param1:String) : void
        {
            return;
        }// end function

        public function isGuideReady() : Boolean
        {
            return UILoaded;
        }// end function

    }
}
