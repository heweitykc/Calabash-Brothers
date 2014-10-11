package com.game.zones.view.bosshome
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.text.*;

    public class BossHomeItemTips extends BaseTips
    {
        private var _content:MovieClip;
        private var _bossModel:MovieClip;
        private var _bossNameTxt:TextField;
        private var _carryTreasureTxt:TextField;
        private var _mapNameTxt:TextField;
        private var _freshTimeTxt:TextField;
        private var _bossBitLogTxt:TextField;
        private var _remainTimeTxt:TextField;
        private var _lifePropTxt:TextField;
        private var _attackPropTxt:TextField;
        private var _defensePropTxt:TextField;
        private var _hitPropTxt:TextField;
        private var _dodgePropTxt:TextField;
        private var _angercountTxt:TextField;

        public function BossHomeItemTips()
        {
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            this._content = ToolKit.getNew("bosshome_bossTips") as MovieClip;
            this._bossModel = this._content.getChildByName("bossModel") as MovieClip;
            addChild(this._content);
            this._carryTreasureTxt = this._content.getChildByName("carryTreasureTxt") as TextField;
            this._mapNameTxt = this._content.getChildByName("mapNameTxt") as TextField;
            this._freshTimeTxt = this._content.getChildByName("freshTimeTxt") as TextField;
            this._remainTimeTxt = this._content.getChildByName("remainTimeTxt") as TextField;
            this._bossBitLogTxt = this._content.getChildByName("bossBitLogTxt") as TextField;
            this._lifePropTxt = this._content.getChildByName("lifePropTxt") as TextField;
            this._attackPropTxt = this._content.getChildByName("attackPropTxt") as TextField;
            this._defensePropTxt = this._content.getChildByName("defensePropTxt") as TextField;
            this._hitPropTxt = this._content.getChildByName("hitPropTxt") as TextField;
            this._dodgePropTxt = this._content.getChildByName("dodgePropTxt") as TextField;
            this._bossNameTxt = this._content.getChildByName("bossNameTxt") as TextField;
            this._angercountTxt = this._content.getChildByName("anger_count") as TextField;
            this.addChild(this._content);
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_2:* = null;
            _loc_2 = param1.config;
            var _loc_3:* = MonsterCfgObj.getInstance().getMonsterCfg(_loc_2.q_monsterid);
            this._bossModel.gotoAndStop(param1.frame);
            this._carryTreasureTxt.htmlText = _loc_2.q_monster_drop;
            this._mapNameTxt.text = MapCfgObj.getInstance().getMap(_loc_2.q_map).mapName;
            this._bossNameTxt.text = _loc_3.q_name;
            this._remainTimeTxt.text = param1.freshtime.text;
            this._freshTimeTxt.htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11951"), [_loc_2.q_lv_limit / 60]);
            this._bossBitLogTxt.htmlText = param1.hitLog;
            this._angercountTxt.text = param1.anger.toString();
            this._lifePropTxt.text = LanguageCfgObj.getInstance().getByIndex("11952") + _loc_3.q_maxhp;
            this._attackPropTxt.text = LanguageCfgObj.getInstance().getByIndex("11953") + _loc_3.q_attack;
            this._defensePropTxt.text = LanguageCfgObj.getInstance().getByIndex("11954") + _loc_3.q_defense;
            this._hitPropTxt.text = LanguageCfgObj.getInstance().getByIndex("11955") + _loc_3.q_hit;
            this._dodgePropTxt.text = LanguageCfgObj.getInstance().getByIndex("11956") + _loc_3.q_dodge;
            return;
        }// end function

        override public function remove() : void
        {
            return;
        }// end function

    }
}
