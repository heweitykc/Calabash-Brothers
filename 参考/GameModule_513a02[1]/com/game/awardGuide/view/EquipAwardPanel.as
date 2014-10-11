package com.game.awardGuide.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.awardGuide.control.*;
    import com.game.backpack.control.*;
    import com.game.backpack.model.*;
    import com.game.clickstream.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.task.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.events.*;
    import flash.text.*;

    public class EquipAwardPanel extends BaseBox implements IGuide
    {
        private var _info:EquipmentInfo;
        private var _layoutInfo:LayoutInfo;
        private var _icon:IconItem;
        private var _equipTxt:TextField;
        private var _okBtn:BaseButton;
        private var _closeBtn:BaseButton;

        public function EquipAwardPanel()
        {
            setWH(250, 179);
            loadDisplay("res/equipawardguide.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("equip_get_box");
            this.initUI();
            this.updateView();
            super.displayReady();
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().FIRST_GET_WEAPOEN_TEAM)) == 0)
            {
                this.registerGuide();
                GuideControl.getInstance().beginGuide(int(GuideConfigObj.getInstance().FIRST_GET_WEAPOEN_TEAM));
            }
            return;
        }// end function

        private function initUI() : void
        {
            this._icon = new IconItem("");
            this._icon.setWH(40, 40);
            this._icon.move(26, 62);
            addChild(this._icon);
            this._equipTxt = getDisplayChildByName("txt");
            this._okBtn = new BaseButton(getDisplayChildByName("ok_btn"));
            this._closeBtn = new BaseButton(getDisplayChildByName("closeBtn"));
            this.addListener();
            return;
        }// end function

        public function get info() : EquipmentInfo
        {
            return this._info;
        }// end function

        public function set info(param1:EquipmentInfo) : void
        {
            this._info = param1;
            return;
        }// end function

        private function updateView() : void
        {
            var _loc_1:* = null;
            if (UILoaded && this._info)
            {
                this._icon.setInfo(this._info);
                _loc_1 = PropUtil.getEquipNameAndColor(this._info);
                this._equipTxt.text = _loc_1[0];
                this._equipTxt.textColor = _loc_1[1];
                if (UserObj.getInstance().playerInfo.level <= 70)
                {
                    TweenLite.delayedCall(TaskGlobal.AUTO_EQUIP_AWARD_OK, this._okAction);
                }
            }
            return;
        }// end function

        private function addListener() : void
        {
            this._closeBtn.addEventListener(MouseEvent.CLICK, this._clickHandler);
            this._okBtn.addEventListener(MouseEvent.CLICK, this._clickHandler);
            return;
        }// end function

        private function _clickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            switch(event.currentTarget)
            {
                case this._okBtn:
                {
                    if (BackpackObj.getInstance().getItemById(this._info.itemId) != null)
                    {
                        ClickStream.quickUseEquip(this._info.q_id);
                        BackPackControl.getInstance().equip(this._info);
                    }
                    this.close();
                    break;
                }
                case this._closeBtn:
                {
                    this.close();
                    _loc_2 = GuideConfigObj.getInstance().FIRST_GET_WEAPOEN_TEAM.split("_");
                    GuideControl.getInstance().finishTeamGuide(_loc_2[0]);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function _okAction() : void
        {
            this._okBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (!this._layoutInfo)
            {
                this._layoutInfo = new LayoutInfo(Layout.CENTER, 300, 0);
            }
            Global.popManager.addUI(this, this._layoutInfo);
            this.updateView();
            return;
        }// end function

        override public function close() : void
        {
            TweenLite.killDelayedCallsTo(this._okAction);
            super.close();
            Global.popManager.removeUI(this);
            if (this._info)
            {
                EquipAwardGuideControl.getInstance().removeGuide(this._info);
            }
            this._info = null;
            return;
        }// end function

        private function adjustPos() : void
        {
            if (this._okBtn)
            {
                x = FrameworkGlobal.stage.mouseX - this._okBtn.x - (this._okBtn.width >> 1);
                y = FrameworkGlobal.stage.mouseY - this._okBtn.y - (this._okBtn.height >> 1);
            }
            return;
        }// end function

        public function registerGuide() : void
        {
            GuideControl.getInstance().registerGuide(this._okBtn, this, GuideConfigObj.getInstance().FIRST_GET_WEAPOEN_GUIDE_ID);
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
            return;
        }// end function

        public function isGuideReady() : Boolean
        {
            return true;
        }// end function

    }
}
