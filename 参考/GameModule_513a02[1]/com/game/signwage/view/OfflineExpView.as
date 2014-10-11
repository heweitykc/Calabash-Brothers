package com.game.signwage.view
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.ui.tips.*;
    import com.f1.vmc.*;
    import com.game.offline.control.*;
    import com.game.operationpanel.view.*;
    import com.game.role.util.*;
    import com.game.worldlevel.event.*;
    import com.game.worldlevel.model.*;
    import com.game.worldlevel.tips.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;

    public class OfflineExpView extends Component
    {
        private var _expitem:OfflineExpItem;
        private var _double_expitem:OfflineExpItem;
        private var _five_expitem:OfflineExpItem;
        private var _ten_expitem:OfflineExpItem;
        private var returnBall:EnergyBall;
        private var returnValue2:TextField;
        private var level_point:Point;
        private var reward_point:Point;
        private var high_point:Point;
        private var low_level_point:Point;
        private var lower_level_point:Point;
        private var level_img_left:Sprite;
        private var level_img_right:Sprite;
        private var low_level_img_left:Sprite;
        private var low_level_img_right:Sprite;
        private var reward_img_left:Sprite;
        private var reward_img_right:Sprite;
        private var _levelImg:ImgNumber;
        private var _low_level_img:ImgNumber;
        private var _reward_img:ImgNumber;
        private const MAX_RETURNVALUE:uint = 50400;
        private var _lower_level_img:ImgNumber;
        private var _help_btn:BaseButton;
        private var _effectMaster:VMCView;
        private var TIP_HELP_STRING:String;
        private var high_level_img_left:Sprite;
        private var high_level_img_right:Sprite;
        private var _highLevel_img:ImgNumber;
        private var lower_level_img_left:Sprite;
        private var lower_level_img_right:Sprite;
        private var higher_level_img:Sprite;
        private var ball:Sprite;

        public function OfflineExpView(param1 = null, param2:String = null)
        {
            this.level_point = new Point(123, 16);
            this.reward_point = new Point(154, 81);
            this.high_point = new Point(185, 56);
            this.low_level_point = new Point(184, 56);
            this.lower_level_point = new Point(126, 56);
            this.TIP_HELP_STRING = "<font color=\'\'>" + " " + LanguageCfgObj.getInstance().getByIndex("12193") + " <br/>" + " " + LanguageCfgObj.getInstance().getByIndex("12194") + " <br/>" + " " + LanguageCfgObj.getInstance().getByIndex("12195") + "</font>";
            super(param1, param2);
            x = 10;
            y = 80;
            super.initComponentUI("offlineExp");
            this.initUI();
            this.addlistener();
            this.update();
            return;
        }// end function

        private function addlistener() : void
        {
            WorldLevelData.getInstance().addEventListener(WorldLevelEvent.WORLD_LEVEL_DATA_CHANGE, this.__updateWorldLevel);
            return;
        }// end function

        private function __updateWorldLevel(event:WorldLevelEvent) : void
        {
            this.update();
            return;
        }// end function

        private function initUI() : void
        {
            this.ball = getDisplayChildByName("ball");
            this.returnBall = new EnergyBall(this.ball.getChildByName("returnBall"));
            this.returnValue2 = this.ball.getChildByName("retunValue2") as TextField;
            this._help_btn = new BaseButton(getDisplayChildByName("btnHelp"));
            this._expitem = new OfflineExpItem(getDisplayChildByName("item_1"));
            this._expitem.type = 1;
            this._double_expitem = new OfflineExpItem(getDisplayChildByName("item_2"));
            this._double_expitem.type = 2;
            this._five_expitem = new OfflineExpItem(getDisplayChildByName("item_3"));
            this._five_expitem.type = 5;
            this._ten_expitem = new OfflineExpItem(getDisplayChildByName("item_4"));
            this._ten_expitem.type = 10;
            this.level_img_left = getDisplayChildByName("pic_1");
            this.level_img_right = getDisplayChildByName("pic_2");
            this.low_level_img_left = getDisplayChildByName("pic_3");
            this.low_level_img_right = getDisplayChildByName("pic_4");
            this.reward_img_left = getDisplayChildByName("pic_5");
            this.reward_img_right = getDisplayChildByName("pic_6");
            this.high_level_img_left = getDisplayChildByName("pic_7");
            this.lower_level_img_left = getDisplayChildByName("pic_8");
            this.lower_level_img_right = getDisplayChildByName("pic_9");
            this.high_level_img_right = getDisplayChildByName("pic_10");
            this.higher_level_img = getDisplayChildByName("pic_11");
            this._reward_img = new ImgNumber();
            this._reward_img.move(this.reward_point.x, this.reward_point.y);
            addChild(this._reward_img);
            this._highLevel_img = new ImgNumber();
            this._highLevel_img.move(this.high_point.x, this.high_point.y);
            addChild(this._highLevel_img);
            this._low_level_img = new ImgNumber();
            this._low_level_img.move(this.low_level_point.x, this.low_level_point.y);
            addChild(this._low_level_img);
            this._levelImg = new ImgNumber();
            this._levelImg.move(this.level_point.x, this.level_point.y);
            this._lower_level_img = new ImgNumber();
            this._lower_level_img.move(this.lower_level_point.x, this.lower_level_point.y);
            addChild(this._lower_level_img);
            addChild(this._levelImg);
            OfflineControl.getInstance().offlineView = this;
            var _loc_1:* = new Object();
            ItemTips.create(this._help_btn, _loc_1, WorldLevelTip);
            return;
        }// end function

        public function update() : void
        {
            this.updateWorldLevel();
            this.updateBall();
            this._ten_expitem.update();
            this._five_expitem.update();
            this._double_expitem.update();
            this._expitem.update();
            return;
        }// end function

        private function updateBall() : void
        {
            this.returnValue2.text = String(int(OfflineControl.getInstance().getExp / this.MAX_RETURNVALUE * 100) + "%");
            this.returnBall.setValue(OfflineControl.getInstance().getExp, this.MAX_RETURNVALUE);
            var _loc_1:* = this.TIP_HELP_STRING.replace("{1}", OfflineControl.getInstance().getExp).replace("{2}", this.MAX_RETURNVALUE);
            StringTip.create(this.ball, _loc_1);
            return;
        }// end function

        private function getWorldLevel() : int
        {
            return WorldLevelData.getInstance().worldLevel;
        }// end function

        private function getRewardPercent() : String
        {
            return WorldLevelData.getInstance().getExpRecoverAddition() + "%";
        }// end function

        private function updateWorldLevel() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = 2;
            var _loc_2:* = this.getWorldLevel();
            if (RoleLevelUtil.isMasterLevel(_loc_2))
            {
                this._levelImg.setNumber(String(_loc_2 - Params.ROLE_MAX_LEVEL), 1, 0);
                if (!this._effectMaster)
                {
                    this._effectMaster = new VMCView();
                    this._effectMaster.move(this.level_point.x + 22, this.level_point.y + 18);
                    this._effectMaster.auto = true;
                    this._effectMaster.updatePose("90", true);
                }
                this.level_img_right.x = 187 + 33;
                this._help_btn.x = 204 + 33;
                this._levelImg.move(this.level_point.x + 33, this.level_point.y);
                this._levelImg.parent.addChild(this._effectMaster);
                this._effectMaster.loadRes("res/effect/bigmaster/master_sign_big_effect.png", null, true);
            }
            else
            {
                this.level_img_right.x = 187;
                this._help_btn.x = 204;
                this._levelImg.move(this.level_point.x, this.level_point.y);
                this._levelImg.setNumber(_loc_2.toString(), 1, 0);
            }
            this.level_img_right.x = this._levelImg.x + this._levelImg.width + _loc_1;
            this._help_btn.x = this.level_img_right.x + this.level_img_right.width + _loc_1;
            var _loc_3:* = UserObj.getInstance().playerInfo;
            if (WorldLevelData.getInstance().isWorldLevelEnabled())
            {
                this._lower_level_img.visible = false;
                if (WorldLevelData.getInstance().isAdditionActive())
                {
                    _loc_4 = (int(_loc_2) - _loc_3.level).toString();
                    this._low_level_img.setNumber(_loc_4, 10, -1);
                    this.low_level_img_right.x = this._low_level_img.x + this._low_level_img.width + _loc_1;
                    _loc_5 = this.getRewardPercent();
                    this._reward_img.setNumber(_loc_5, 10, -1);
                    this.reward_img_right.x = this._reward_img.x + this._reward_img.width + _loc_1;
                    this._low_level_img.visible = true;
                    this.low_level_img_left.visible = true;
                    this.low_level_img_right.visible = true;
                    this.reward_img_left.visible = true;
                    this.reward_img_right.visible = true;
                    this._reward_img.visible = true;
                    this.high_level_img_left.visible = false;
                    this.high_level_img_right.visible = false;
                    this.lower_level_img_right.visible = false;
                    this._highLevel_img.visible = false;
                    this.lower_level_img_left.visible = false;
                    this.higher_level_img.visible = false;
                }
                else
                {
                    this._low_level_img.visible = false;
                    this.low_level_img_left.visible = false;
                    this.low_level_img_right.visible = false;
                    this.reward_img_left.visible = false;
                    this.reward_img_right.visible = false;
                    this._reward_img.visible = false;
                    if (_loc_3.level >= WorldLevelData.getInstance().worldLevel)
                    {
                        this._highLevel_img.visible = false;
                        this.high_level_img_left.visible = false;
                        this.high_level_img_right.visible = false;
                        this.higher_level_img.visible = true;
                    }
                    else
                    {
                        this.high_level_img_left.visible = true;
                        this._highLevel_img.setNumber(GlobalCfgObj.getInstance().getWorldLevelEnableMinPlayerLevelDif().toString(), 10, -1);
                        this._highLevel_img.visible = true;
                        this.high_level_img_right.visible = true;
                        this.high_level_img_right.x = this._highLevel_img.x + this._highLevel_img.width + _loc_1;
                        this.higher_level_img.visible = false;
                    }
                    this.lower_level_img_right.visible = false;
                    this.lower_level_img_left.visible = false;
                }
            }
            else
            {
                this._low_level_img.visible = false;
                this.low_level_img_left.visible = false;
                this.low_level_img_right.visible = false;
                this.reward_img_left.visible = false;
                this.reward_img_right.visible = false;
                this._reward_img.visible = false;
                this._highLevel_img.visible = false;
                this.high_level_img_left.visible = false;
                this.high_level_img_right.visible = false;
                this.higher_level_img.visible = false;
                this.lower_level_img_left.visible = true;
                this.lower_level_img_right.visible = true;
                this._lower_level_img.setNumber(WorldLevelConst.worldLevelEnablePlayerLevel.toString(), 10, -1);
                this.lower_level_img_right.x = this._lower_level_img.x + this._lower_level_img.width + _loc_1;
                this._lower_level_img.visible = true;
            }
            return;
        }// end function

    }
}
