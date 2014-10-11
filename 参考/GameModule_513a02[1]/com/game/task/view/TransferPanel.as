package com.game.task.view
{
    import com.*;
    import com.f1.*;
    import com.f1.events.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.clickstream.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.task.*;
    import com.game.task.model.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.text.*;

    public class TransferPanel extends Component implements IGuide
    {
        public var txt_title:TextField;
        public var txt_desc:TextField;
        public var btn_submit:BaseButton;
        private var TRANSFOR_BTN_TEXT:String;
        private var isAutoClick:Boolean = false;
        private var _coord:TaskCoordVO;
        private var curTimeStr:String;
        private var _countDown:int;

        public function TransferPanel()
        {
            this.TRANSFOR_BTN_TEXT = LanguageCfgObj.getInstance().getByIndex("11344");
            initComponentUI("TransferPanelSkin");
            this.txt_title = getDisplayChildByName("txt_title") as TextField;
            this.txt_desc = getDisplayChildByName("txt_desc") as TextField;
            this.btn_submit = new BaseButton(getDisplayChildByName("btn_submit"));
            this.btn_submit.setText(this.TRANSFOR_BTN_TEXT);
            this.btn_submit.addEventListener(MouseEvent.CLICK, this.onClickHandle);
            return;
        }// end function

        public function get coord() : TaskCoordVO
        {
            return this._coord;
        }// end function

        public function set coord(param1:TaskCoordVO) : void
        {
            this._coord = param1;
            if (this._coord.mapId == Params.ICE_WIND_MAP_ID)
            {
                this.registerGuide();
                GuideMultiControl.getInstance().beginGuide(int(GuideConfigObj.getInstance().ICE_WIND_TRANSFOR_TEAM));
            }
            return;
        }// end function

        private function onClickHandle(event:MouseEvent = null) : void
        {
            if (this.coord && !this.isAutoClick)
            {
                if (MapObj.getInstance().mapID == Params.MAINLAND_MAP_ID && this.coord.mapId == Params.UNDER_CITY_1_MAP_ID)
                {
                    ClickStream.add(ClickStreamId.CLICK_SWITCHMAP_YongZheDaLu_to_DiXiaCheng);
                }
                if (MapObj.getInstance().mapID == Params.ICE_WIND_MAP_ID && this.coord.mapId == Params.UNDER_CITY_2_MAP_ID)
                {
                    ClickStream.add(ClickStreamId.CLICK_SWITCHMAP_BingFengGu_to_DiXiaCheng);
                }
            }
            this.isAutoClick = false;
            this.clickAction();
            return;
        }// end function

        private function autoClick(event:TimerManagerEvent = null) : void
        {
            this.isAutoClick = true;
            this.btn_submit.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            return;
        }// end function

        private function clickAction(event:TimerManagerEvent = null) : void
        {
            if (this.coord)
            {
                ClickStream.transferGuide(this.coord.taskId);
                if (this.coord.num == 1)
                {
                    MapClientControl.getInstance().clientChangeMap(this.coord.mapId);
                }
                else
                {
                    TaskGlobal.manager.transferScene(this.coord);
                    TaskGlobal.isChangeSceneContinueTask = true;
                }
            }
            Global.mainUIManager.removeUI(this);
            this.countDown = 0;
            return;
        }// end function

        public function set countDown(param1:int) : void
        {
            this._countDown = param1;
            if (this._countDown > 0)
            {
                this.curTimeStr = TimerManager.registerTimer(1, this._countDown + 2, this._updateCountDown, this.autoClick);
            }
            else
            {
                if (this.curTimeStr && this.curTimeStr != "")
                {
                    TimerManager.killTimer(this.curTimeStr);
                }
                this._updateCountDown();
                this._setBtnText();
            }
            return;
        }// end function

        private function _updateCountDown(event:TimerManagerEvent = null) : void
        {
            this._setBtnText();
            var _loc_2:* = this;
            var _loc_3:* = this._countDown - 1;
            _loc_2._countDown = _loc_3;
            return;
        }// end function

        private function _setBtnText() : void
        {
            if (this._countDown <= 0)
            {
                this.btn_submit.setText(this.TRANSFOR_BTN_TEXT);
            }
            else
            {
                this.btn_submit.setText(this.TRANSFOR_BTN_TEXT + "(" + this._countDown + ")");
            }
            return;
        }// end function

        public function registerGuide() : void
        {
            GuideMultiControl.getInstance().registerGuide(this.btn_submit, this, GuideConfigObj.getInstance().ICE_WIND_TRANSFOR_GUIDE_ID_1);
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            return;
        }// end function

        public function guideEnd(param1:String) : void
        {
            GuideMultiControl.getInstance().unregisterGuide(this.btn_submit, param1);
            return;
        }// end function

        public function isGuideReady() : Boolean
        {
            return true;
        }// end function

    }
}
