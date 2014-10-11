package com.view.tipcell.equip
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.container.*;
    import com.model.vo.*;
    import flash.text.*;

    public class SkillItem extends BaseItem
    {
        private var _skillTxt:TextField;

        public function SkillItem()
        {
            this._skillTxt = new TextField();
            this._skillTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._skillTxt.defaultTextFormat = _textFormat;
            return;
        }// end function

        public function repaintSkill(param1:EquipmentInfo, param2:HBox) : void
        {
            var _loc_3:* = null;
            if (param1.q_attach_skill)
            {
                _loc_3 = SkillCfgObj.getInstance().getSkillInfoById(param1.q_attach_skill);
                this._skillTxt.htmlText = _loc_3.q_skillName + "（MP：" + _loc_3.q_need_mp + "）";
                this._skillTxt.height = this._skillTxt.textHeight + 4;
                if (this._skillTxt.parent == null)
                {
                    addChild(this._skillTxt);
                }
                param2.add(this);
                addGapPoint(this._skillTxt.y);
                addGapLine(this._skillTxt.y + this._skillTxt.height);
            }
            else
            {
                param2.remove(this);
            }
            return;
        }// end function

    }
}
