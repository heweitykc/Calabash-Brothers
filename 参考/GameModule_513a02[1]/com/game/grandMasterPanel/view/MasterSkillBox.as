package com.game.grandMasterPanel.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.image.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.grandMasterPanel.control.*;
    import com.game.guide.control.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.tips.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class MasterSkillBox extends Component
    {
        private var _firstAllowAdd:Boolean = true;
        private var _data:MasterSkillVO;
        private var iconMc:MovieClip;
        private var _icon:Image;
        private var addBtn:BaseButton;
        private var countTf:TextField;
        static var _autoAddPoint:Boolean;

        public function MasterSkillBox()
        {
            super(ToolKit.getNew("grandMasterSkillPanel.item"));
            this.iconMc = getDisplayChildByName("iconMc");
            this._icon = new Image();
            this._icon.setSize(44, 44);
            this.iconMc.addChild(this._icon);
            this.addBtn = new BaseButton(getDisplayChildByName("addBtn"));
            this.countTf = getDisplayChildByName("countTf");
            this.countTf.mouseEnabled = false;
            this.countTf.tabEnabled = false;
            this.countTf.mouseWheelEnabled = false;
            return;
        }// end function

        private function onAddHandler(event:MouseEvent) : void
        {
            if (this._data)
            {
                if (this._data.cfg.q_cost_point > MasterSkillData.instance.masterSkillPoint)
                {
                    Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("MasterSkillBox_1406014528", "lang_masterSkill"));
                    return;
                }
                if (_autoAddPoint)
                {
                    this.onConfirmHandler(this._data.skillId);
                }
                else
                {
                    Global.popManager.cue(StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("MasterSkillBox_1405996367", "lang_masterSkill"), this._data.cfg.q_name), null, [this._data.skillId], this.onConfirmHandler, null, 2, null, false, true, this.onConfirmCheckHandler);
                }
            }
            return;
        }// end function

        private function onConfirmHandler(param1:int) : void
        {
            MasterSkillControl.instance.protocol.reqStudyMasterSkill(param1);
            return;
        }// end function

        private function onConfirmCheckHandler(param1:Boolean) : void
        {
            _autoAddPoint = param1;
            return;
        }// end function

        override public function finalize() : void
        {
            this._data = null;
            ItemTips.dispose(this.iconMc);
            this.iconMc = null;
            this._icon.dispose();
            this._icon = null;
            ButtonFlickerControl.getInstance().removeButtonFlicker(this.addBtn);
            StringTip.dispose(this.addBtn);
            this.addBtn.removeEvtListener(MouseEvent.CLICK, this.onAddHandler);
            this.addBtn.finalize();
            this.addBtn = null;
            this.countTf = null;
            super.finalize();
            return;
        }// end function

        public function set data(param1:MasterSkillVO) : void
        {
            if (this._data)
            {
                if (!this._firstAllowAdd && param1.allowAddPoint)
                {
                    ButtonFlickerControl.getInstance().addButtonFlicker(this.addBtn);
                    TweenLite.delayedCall(3, this.onResetFilterHandler);
                }
            }
            this._firstAllowAdd = param1.allowAddPoint;
            this._data = param1;
            this._icon.load(param1.url);
            this._icon.setSize(44, 44);
            this.countTf.text = this._data.level + "/" + this._data.cfg.q_max_level;
            if (this._data.isCanLevelUp)
            {
                this.addBtn.visible = true;
                if (this._data.allowAddPoint)
                {
                    this.addBtn.filters = [];
                    this.addBtn.addEvtListener(MouseEvent.CLICK, this.onAddHandler);
                }
                else
                {
                    this.addBtn.filters = [FrameworkGlobal.colorMat];
                    this.addBtn.removeEvtListener(MouseEvent.CLICK, this.onAddHandler);
                }
                if (this._data.isOpened)
                {
                    this.iconMc.filters = [];
                }
                else
                {
                    this.iconMc.filters = [FrameworkGlobal.colorMat];
                }
                StringTip.create(this.addBtn, this._data.conditionTips);
            }
            else
            {
                StringTip.dispose(this.addBtn);
                this.addBtn.visible = false;
                this.iconMc.filters = [];
            }
            ItemTips.create(this.iconMc, this._data, MasterSkillTips);
            return;
        }// end function

        public function get data() : MasterSkillVO
        {
            return this._data;
        }// end function

        private function onResetFilterHandler() : void
        {
            ButtonFlickerControl.getInstance().removeButtonFlicker(this.addBtn);
            return;
        }// end function

    }
}
