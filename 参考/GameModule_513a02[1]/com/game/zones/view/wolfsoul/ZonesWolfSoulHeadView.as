package com.game.zones.view.wolfsoul
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.text.*;

    public class ZonesWolfSoulHeadView extends Component
    {
        private var _levelTxt:TextField;
        private var _nameTxt:TextField;
        private var close_btn:BaseButton;
        private var mc_hp:MovieClip;
        private var mc_hp_back:MovieClip;
        private var stripWidth:Number;
        private var whiteMask:BaseSprite;
        private var curHp:int;
        private var maxHp:int;
        private var monsterName:String;
        private var monsterId:int;

        public function ZonesWolfSoulHeadView(param1 = null, param2:String = null)
        {
            super(param1, param2);
            loadDisplay("res/selectmonsterbox.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("selectmonsterbox");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._levelTxt = getDisplayChildByName("txt_level");
            this._nameTxt = getDisplayChildByName("txt_name");
            this.close_btn = new BaseButton(getDisplayChildByName("close_btn"));
            this.mc_hp = getDisplayChildByName("mc_hp");
            this.mc_hp_back = getDisplayChildByName("mc_hp_back");
            this.stripWidth = this.mc_hp.width;
            this._nameTxt.selectable = false;
            this._levelTxt.selectable = false;
            this.close_btn.visible = false;
            if (this.monsterName)
            {
                this.updateMonsterName(this.monsterName);
            }
            else
            {
                this.updateMonsterName("");
            }
            this.updateHp(this.curHp, this.curHp);
            return;
        }// end function

        public function updateHp(param1:int, param2:int) : void
        {
            this.curHp = param1;
            this.maxHp = param2;
            if (!UILoaded)
            {
                return;
            }
            this.mc_hp.mc_mask.width = this.stripWidth * param1 / param2;
            this.mc_hp.txt.text = param1 + "/" + param2;
            TweenLite.to(this.mc_hp_back.mc_mask, 0.3, {width:this.mc_hp.mc_mask.width});
            return;
        }// end function

        public function updateMonsterId(param1:int) : void
        {
            this.monsterId = param1;
            var _loc_2:* = MonsterCfgObj.getInstance().getMonsterCfg(this.monsterId);
            this.monsterName = _loc_2.q_name;
            if (!UILoaded)
            {
                return;
            }
            this.updateMonsterName(_loc_2.q_name);
            return;
        }// end function

        private function updateMonsterName(param1:String) : void
        {
            this.monsterName = param1;
            if (!UILoaded)
            {
                return;
            }
            if (param1 != "")
            {
                this._levelTxt.htmlText = param1;
            }
            else
            {
                this._levelTxt.text = param1;
            }
            return;
        }// end function

        public function open() : void
        {
            return;
        }// end function

    }
}
