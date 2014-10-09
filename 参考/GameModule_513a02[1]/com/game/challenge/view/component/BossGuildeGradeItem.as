package com.game.challenge.view.component
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.utils.*;
    import com.f1.utils.path.*;
    import com.game.challenge.control.*;
    import com.game.map.control.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import com.view.ui.list.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import interfaces.role.*;

    public class BossGuildeGradeItem extends ListItem
    {
        private var _challengeBtn:BaseButton;
        private var _gotoBtn:BaseButton;
        private var _conditionTxt:TextField;
        private var _dropTxt:TextField;
        private var _dropBox:HBox;
        private var _maskMc:MovieClip;
        private var _mapViewMc:MovieClip;
        private var _levelNameTxt:TextField;

        public function BossGuildeGradeItem(param1:String = "bossGuilde_GradeItem", param2:String = "")
        {
            super(param1, param2);
            addEvtListener(MouseEvent.CLICK, this.__click);
            return;
        }// end function

        override protected function getComp() : void
        {
            this._challengeBtn = new BaseButton(_content.getChildByName("challengeBtn"));
            this._gotoBtn = new BaseButton(_content.getChildByName("gotoBtn"));
            this._conditionTxt = _content.getChildByName("conditionTxt") as TextField;
            this._levelNameTxt = _content.getChildByName("levelNameTxt") as TextField;
            this._dropTxt = _content.getChildByName("dropTxt") as TextField;
            this._maskMc = _content.getChildByName("maskMc") as MovieClip;
            this._mapViewMc = _content.getChildByName("mapViewMc") as MovieClip;
            this._dropBox = new HBox();
            this._dropBox.oneRow = 0;
            this._dropBox.horizontal = true;
            this._dropBox.move(442, 112);
            this._dropBox.intervalX = 3;
            addChild(this._dropBox);
            return;
        }// end function

        public function enterMap(event:MouseEvent) : void
        {
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = obj;
            switch(event.target)
            {
                case this._gotoBtn:
                {
                    _loc_3 = RoleList.getInstance().player;
                    _loc_3.pathByCoo(_loc_2.q_map_x * MapUtils.GRID_BORDER, _loc_2.q_map_y * MapUtils.GRID_BORDER, 1, _loc_2.q_map);
                    BossGuideControl.getInstance().openOrCloseBossGuildPanel();
                    break;
                }
                case this._challengeBtn:
                {
                    MapControl.getInstance().changeMapByPos(_loc_2.q_map, _loc_2.q_map_x, _loc_2.q_map_y, new long(), 0);
                    BossGuideControl.getInstance().openOrCloseBossGuildPanel();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override protected function receive() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            _loc_1 = obj;
            if (!_loc_1)
            {
                return;
            }
            this._conditionTxt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11901"), [_loc_1.q_lv_limit]);
            var _loc_3:* = _loc_1.q_drop_neutrality.split(";");
            this._mapViewMc.gotoAndStop(_loc_1.q_id);
            var _loc_6:* = 0;
            while (_loc_6 < _loc_3.length)
            {
                
                _loc_2 = new IconItem("commonRewardBox2_40");
                _loc_2.image.move(4, 4);
                _loc_4 = (_loc_3[_loc_6] as String).split("_");
                _loc_5 = PropUtil.createItemByCfg(_loc_4[0]);
                _loc_2.setInfo(_loc_5);
                this._dropBox.add(_loc_2);
                _loc_6++;
            }
            if (UserObj.getInstance().playerInfo.vipid >= 1)
            {
                this._gotoBtn.visible = false;
                this._challengeBtn.visible = true;
            }
            else
            {
                this._challengeBtn.visible = false;
                this._gotoBtn.visible = true;
            }
            this._levelNameTxt.text = MapCfgObj.getInstance().getMap(_loc_1.q_map).mapName;
            if (UserObj.getInstance().playerInfo.level < _loc_1.q_lv_limit)
            {
                this._maskMc.visible = true;
                addChild(this._maskMc);
                this._conditionTxt.htmlText = "<font color=\'#ff0000\'>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11901"), [_loc_1.q_lv_limit]) + "</font>";
                addChild(this._conditionTxt);
            }
            else
            {
                this._maskMc.visible = false;
            }
            return;
        }// end function

        override public function finalize() : void
        {
            removeEvtListener(MouseEvent.CLICK, this.__click);
            super.finalize();
            return;
        }// end function

    }
}
