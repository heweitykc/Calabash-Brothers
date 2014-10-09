package com.game.player.view
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.text.*;

    public class ChangeJobBossTips extends BaseTips
    {
        private var _content:MovieClip;
        private var _bossModel:MovieClip;
        private var _bossNameTxt:TextField;
        private var _lifePropTxt:TextField;
        private var _attackPropTxt:TextField;
        private var _defensePropTxt:TextField;
        private var _hitPropTxt:TextField;
        private var _dodgePropTxt:TextField;

        public function ChangeJobBossTips()
        {
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            this._content = ToolKit.getNew("changeJob_bossTips") as MovieClip;
            this._bossModel = this._content.getChildByName("bossModel") as MovieClip;
            addChild(this._content);
            this._lifePropTxt = this._content.getChildByName("lifePropTxt") as TextField;
            this._attackPropTxt = this._content.getChildByName("attackPropTxt") as TextField;
            this._defensePropTxt = this._content.getChildByName("defensePropTxt") as TextField;
            this._hitPropTxt = this._content.getChildByName("hitPropTxt") as TextField;
            this._dodgePropTxt = this._content.getChildByName("dodgePropTxt") as TextField;
            this._bossNameTxt = this._content.getChildByName("bossNameTxt") as TextField;
            this.addChild(this._content);
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_2:* = param1.config;
            var _loc_3:* = MonsterCfgObj.getInstance().getMonsterCfg(_loc_2.q_monsterid);
            this._bossModel.gotoAndStop(param1.frame);
            this._bossNameTxt.text = LanguageCfgObj.getInstance().getByIndex("12357") + _loc_3.q_name;
            this._lifePropTxt.text = LanguageCfgObj.getInstance().getByIndex("11952") + 19852663;
            this._attackPropTxt.text = LanguageCfgObj.getInstance().getByIndex("11953") + 8192;
            this._defensePropTxt.text = LanguageCfgObj.getInstance().getByIndex("11954") + 3035;
            this._hitPropTxt.text = LanguageCfgObj.getInstance().getByIndex("11955") + 4666;
            this._dodgePropTxt.text = LanguageCfgObj.getInstance().getByIndex("11956") + 95;
            return;
        }// end function

        override public function remove() : void
        {
            return;
        }// end function

    }
}
