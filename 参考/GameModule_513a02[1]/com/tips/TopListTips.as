package com.tips
{
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.utils.*;
    import com.game.equip.bean.*;
    import com.game.role.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.text.*;

    public class TopListTips extends BaseTips
    {
        private var nameTxt:TextField;
        private var guildTxt:TextField;
        private var vmcMc:MovieClip;
        private var fightNumMc:MovieClip;
        private var _fnumber:ImgNumber;
        private var _bodyVmc:Role;

        public function TopListTips()
        {
            var _loc_1:* = ToolKit.getNew("toplistpanel.topTips");
            addChild(_loc_1);
            this.nameTxt = _loc_1.nameTxt;
            this.guildTxt = _loc_1.guildTxt;
            this.vmcMc = _loc_1.vmcMc;
            this.fightNumMc = _loc_1.fightNumMc;
            this._fnumber = new ImgNumber();
            this.fightNumMc.addChild(this._fnumber);
            this._bodyVmc = new Role();
            this._bodyVmc.auto = true;
            this.vmcMc.addChild(this._bodyVmc);
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_2:* = param1 as TopListInfo;
            if (_loc_2)
            {
                this.nameTxt.text = _loc_2.playername;
                this.guildTxt.text = _loc_2.guildinfo ? (_loc_2.guildinfo.guildName ? (LanguageCfgObj.getInstance().getByIndex("12353") + _loc_2.guildinfo.guildName) : ("")) : ("");
                this._fnumber.setNumber(_loc_2.fightPower + "", 3, -5);
                _loc_3 = _loc_2.getEuipByPost((Params.BODY - 1));
                _loc_4 = _loc_3 ? (ItemCfgObj.getInstance().getItemCfg(_loc_3.itemModelId)) : (null);
                if (_loc_4)
                {
                    _loc_4.streng = _loc_3.itemLevel;
                }
                _loc_5 = _loc_2.getEuipByPost((Params.LEFT_WEAPON - 1));
                _loc_6 = ItemCfgObj.getInstance().getItemCfg(_loc_5 ? (_loc_5.itemModelId) : (0));
                if (_loc_6)
                {
                    _loc_6.streng = _loc_5.itemLevel;
                }
                _loc_7 = _loc_2.getEuipByPost((Params.RIGHT_WEAPON - 1));
                _loc_8 = ItemCfgObj.getInstance().getItemCfg(_loc_7 ? (_loc_7.itemModelId) : (0));
                if (_loc_8)
                {
                    _loc_8.streng = _loc_7.itemLevel;
                }
                _loc_9 = _loc_2.getEuipByPost((Params.WING - 1));
                _loc_10 = ItemCfgObj.getInstance().getItemCfg(_loc_9 ? (_loc_9.itemModelId) : (0));
                if (_loc_10)
                {
                    _loc_10.streng = _loc_9.itemLevel;
                }
                _loc_11 = this._bodyVmc.info;
                if (_loc_11 == null)
                {
                    _loc_11 = new RoleInfo();
                }
                _loc_11.setRoleInfo(_loc_2.level, _loc_3 ? (_loc_3.itemModelId) : (0), _loc_2.job, _loc_4, _loc_6, _loc_8, _loc_10);
                _loc_11.personId = new long();
                _loc_11.roleType = RoleType.ROLE_TYPE_NPC;
                _loc_11.suitEffectCount = _loc_2.suitEffectCount;
                _loc_11.suitEffectIds = _loc_2.suitEffectIds;
                this._bodyVmc.info = _loc_11;
            }
            else
            {
                this.nameTxt.text = "";
                this.guildTxt.text = "";
                this._fnumber.finalize();
                this._bodyVmc.finalize();
            }
            return;
        }// end function

        override public function remove() : void
        {
            super.remove();
            this.finalize();
            return;
        }// end function

        override public function finalize() : void
        {
            this.nameTxt = null;
            this.guildTxt = null;
            this.vmcMc = null;
            this.fightNumMc = null;
            this._fnumber.finalize();
            this._bodyVmc.finalize();
            super.finalize();
            return;
        }// end function

    }
}
