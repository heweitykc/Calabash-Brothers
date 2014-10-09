package com.game.equipstreng.view
{
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.game.equipstreng.cfg.*;
    import com.game.player.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.tips.*;
    import com.util.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class SuitPanel extends Component
    {
        private var suitView3:MovieClip;
        private var suitView5:MovieClip;
        private var suitNameTxt:TextField;
        private var suitDescTxt:TextField;
        private var transIcon:MovieClip;
        private var strengthIcon:MovieClip;

        public function SuitPanel(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this.suitView3 = getDisplayChildByName("suitView3");
            this.suitView3.addEventListener(MouseEvent.MOUSE_OVER, this.onSuitViewMouseOver, false, 0, true);
            this.suitView3.addEventListener(MouseEvent.MOUSE_OUT, this.onSuitViewMouseOut, false, 0, true);
            this.suitView5 = getDisplayChildByName("suitView5");
            this.suitView5.addEventListener(MouseEvent.MOUSE_OVER, this.onSuitViewMouseOver, false, 0, true);
            this.suitView5.addEventListener(MouseEvent.MOUSE_OUT, this.onSuitViewMouseOut, false, 0, true);
            this.suitNameTxt = getDisplayChildByName("suitNameTxt");
            this.suitNameTxt.text = "";
            this.suitDescTxt = getDisplayChildByName("suitDescTxt");
            this.suitDescTxt.text = "";
            this.transIcon = getDisplayChildByName("transIcon");
            this.strengthIcon = getDisplayChildByName("strengthIcon");
            return;
        }// end function

        public function updateInfo(param1:EquipmentInfo, param2:int) : void
        {
            var _loc_4:* = false;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_3:* = SuitCfgObj.instance.getSuitById(param1.suitId);
            _loc_4 = param2 == EquipOperationTypeCfg.STRENGTHEN_SUIT_TYPE;
            this.transIcon.visible = param2 == EquipOperationTypeCfg.TRANS_SUIT_TYPE;
            this.strengthIcon.visible = param2 == EquipOperationTypeCfg.STRENGTHEN_SUIT_TYPE;
            this.suitView3.visible = _loc_4;
            this.suitView5.visible = _loc_4;
            if (_loc_3)
            {
                this.suitNameTxt.textColor = PropUtil.getEquipColor(param1);
                _loc_5 = UserObj.getInstance().playerInfo.job;
                if (param1.isUseForJob(_loc_5))
                {
                    _loc_7 = EquipsObj.getInstance().getSuitCount(param1.suitId, param1.q_kind, param1.pos) + 1;
                    this.suitNameTxt.text = StringUtil.formatString("{0}({1}/{2})", _loc_3.q_name, _loc_7, _loc_3.total_count);
                    this.suitDescTxt.htmlText = _loc_3.attributeDesc(_loc_7);
                }
                else
                {
                    this.suitNameTxt.text = _loc_3.q_name;
                    this.suitDescTxt.htmlText = _loc_3.attributeDesc(0);
                }
                ItemTips.create(this.suitView3, [param1.suitId, 3], SuitViewTips);
                _loc_6 = SuitEffectCfgObj.instance.getSuitEffectByCount(param1.suitId, 5);
                if (_loc_6)
                {
                    this.suitView5.visible = _loc_4;
                    ItemTips.create(this.suitView5, [param1.suitId, 5], SuitViewTips);
                }
                else
                {
                    this.suitView5.visible = false;
                }
            }
            else
            {
                this.suitNameTxt.text = "";
                this.suitDescTxt.text = "";
                ItemTips.dispose(this.suitView3);
                ItemTips.dispose(this.suitView5);
            }
            return;
        }// end function

        public function clear(param1:int) : void
        {
            this.transIcon.visible = param1 == EquipOperationTypeCfg.TRANS_SUIT_TYPE;
            this.strengthIcon.visible = param1 == EquipOperationTypeCfg.STRENGTHEN_SUIT_TYPE;
            this.suitView3.visible = param1 == EquipOperationTypeCfg.STRENGTHEN_SUIT_TYPE;
            this.suitView5.visible = param1 == EquipOperationTypeCfg.STRENGTHEN_SUIT_TYPE;
            this.suitView3.filters = null;
            this.suitView5.filters = null;
            this.suitNameTxt.text = "";
            this.suitDescTxt.text = "";
            ItemTips.dispose(this.suitView3);
            ItemTips.dispose(this.suitView5);
            return;
        }// end function

        private function onSuitViewMouseOver(event:MouseEvent) : void
        {
            var _loc_2:* = event.target as MovieClip;
            _loc_2.filters = [FrameworkGlobal.YELLOW_TXT_FILTER];
            return;
        }// end function

        private function onSuitViewMouseOut(event:MouseEvent) : void
        {
            var _loc_2:* = event.target as MovieClip;
            _loc_2.filters = null;
            return;
        }// end function

    }
}
