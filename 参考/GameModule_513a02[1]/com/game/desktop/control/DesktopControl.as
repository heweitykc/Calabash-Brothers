package com.game.desktop.control
{
    import __AS3__.vec.*;
    import com.game.desktop.*;
    import com.game.guide.model.*;
    import com.game.operationpanel.control.*;
    import com.game.prompt.utils.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.net.*;

    public class DesktopControl extends Object
    {
        private var _protocol:DesktopProtocol;
        private static var _instance:DesktopControl;

        public function DesktopControl()
        {
            this._protocol = new DesktopProtocol();
            return;
        }// end function

        public function saveLinkToDeskTop() : void
        {
            OperationPanelControl.getInstance().openWeiDuanPanel();
            return;
        }// end function

        public function saveDeskTopLink() : void
        {
            this.addDesktopUrl(Params.GAME_NAME, Params.officialWebSite);
            return;
        }// end function

        public function getAwards(param1:Vector.<ItemInfo>) : void
        {
            var _loc_2:* = new Array();
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_2.push(param1[_loc_3].itemModelId);
                _loc_3++;
            }
            ItemGetAnim.doFlyGetItemsToBack(_loc_2);
            return;
        }// end function

        public function reqCollectionReward() : void
        {
            this._protocol.reqCollectionReward();
            return;
        }// end function

        public function addDesktopUrl(param1:String, param2:String) : void
        {
            var _loc_5:* = null;
            var _loc_3:* = new FileReference();
            var _loc_4:* = "[InternetShortcut]" + "\n";
            _loc_4 = "[InternetShortcut]" + "\n" + ("URL=" + param2 + "\n");
            _loc_5 = "http://res.dts.37wan.com/B32x32.ico";
            _loc_4 = _loc_4 + ("IconFile=" + _loc_5 + "\n");
            _loc_4 = _loc_4 + ("IconIndex=0" + "\n");
            _loc_3.save(_loc_4, param1 + ".url");
            return;
        }// end function

        protected function onComplete(event:Event) : void
        {
            this.reqCollectionReward();
            GuideConfigObj.getInstance().saveConfigByTeam(int(GuideConfigObj.getInstance().DESKTOP_ACTIVE_TEAM), 1);
            return;
        }// end function

        public static function getInsatnce() : DesktopControl
        {
            if (!_instance)
            {
                _instance = new DesktopControl;
            }
            return _instance;
        }// end function

    }
}
