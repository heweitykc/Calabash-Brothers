package com.game.guide.control
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.game.guide.view.*;
    import com.game.map.event.*;
    import com.game.map.model.*;
    import com.model.vo.*;

    public class VipGuideControl extends Object
    {
        private var needShowEndView:Boolean = false;
        private var _panel:VipGuidePanel;
        private var _countView:VipGuideCountView;
        private static var _instance:VipGuideControl;

        public function VipGuideControl()
        {
            return;
        }// end function

        public function showGetVipView(param1:int) : void
        {
            var _loc_2:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (param1 == 1 && _loc_2.mapZones > 0)
            {
                this.needShowEndView = true;
                FrameworkGlobal.addMsgListen(MapEvent.MAP_CHANGE, this.onChangeMapHandler);
                return;
            }
            if (!this._panel)
            {
                this._panel = new VipGuidePanel();
            }
            this._panel.viewType = param1;
            this._panel.open();
            return;
        }// end function

        public function showVipCountDown() : void
        {
            if (!this._countView)
            {
                this._countView = new VipGuideCountView();
            }
            this._countView.open();
            return;
        }// end function

        public function closeVipCount() : void
        {
            if (this._countView)
            {
                this._countView.close();
            }
            return;
        }// end function

        private function onChangeMapHandler(event:MapEvent) : void
        {
            var _loc_2:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (_loc_2.mapZones <= 0 && this.needShowEndView)
            {
                FrameworkGlobal.removeMsgListen(MapEvent.MAP_CHANGE, this.onChangeMapHandler);
                this.needShowEndView = false;
                this.showGetVipView(1);
            }
            return;
        }// end function

        public static function getInstance() : VipGuideControl
        {
            var _loc_1:* = new VipGuideControl;
            _instance = new VipGuideControl;
            return _instance || _loc_1;
        }// end function

    }
}
