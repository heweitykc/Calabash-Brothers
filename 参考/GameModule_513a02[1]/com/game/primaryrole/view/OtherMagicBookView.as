package com.game.primaryrole.view
{
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.chat.control.*;
    import com.game.guild.control.*;
    import com.game.magicbook.model.*;
    import com.game.magicbook.view.compent.*;
    import com.game.primaryrole.control.*;
    import com.game.team.control.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class OtherMagicBookView extends Component
    {
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var btn3:BaseButton;
        private var btn4:BaseButton;
        private var _bookView:VMCView;
        private var _magicNum:ImgNumber;
        private var _attackSpeedTxt:TextField;
        private var _attackPowerTxt:TextField;
        private var _skillBoxes:HBox;
        private var _starBoxes:HBox;
        private var _turnleftBtn:BaseButton;
        private var _turnrighttBtn:BaseButton;
        private var _btnRightRot:BaseButton;
        private var _btnLeftRot:BaseButton;
        private var _skillBoxMask:DisplayObject;
        private var _playerMagicInfo:MagicBookInfo;
        private var _modelDir:int = 4;
        private var allSkillnum:int = 0;
        private var currentSkillIndex:int = 0;
        private static const STAR_NUM:int = 10;

        public function OtherMagicBookView()
        {
            loadDisplay("res/magicbookpanelother.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            this._playerMagicInfo = MagicBookData.getOtherMagicInfo();
            initComponentUI("magicBookOther_main");
            super.displayReady();
            this.initUI();
            this.addEvents();
            this.updateUI();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_1:* = null;
            this.btn1 = new BaseButton(getDisplayChildByName("btn1"));
            this.btn2 = new BaseButton(getDisplayChildByName("btn2"));
            this.btn3 = new BaseButton(getDisplayChildByName("btn3"));
            this.btn4 = new BaseButton(getDisplayChildByName("btn4"));
            this._btnLeftRot = new BaseButton(getDisplayChildByName("btnLeftRot"));
            this._btnRightRot = new BaseButton(getDisplayChildByName("btnRightRot"));
            this._turnleftBtn = new BaseButton(getDisplayChildByName("turnleftBtn"));
            this._turnrighttBtn = new BaseButton(getDisplayChildByName("turnrighttBtn"));
            this.btn1.setText(LanguageCfgObj.getInstance().getByIndex("11032"), true);
            this.btn2.setText(LanguageCfgObj.getInstance().getByIndex("11033"), true);
            this.btn4.setText(LanguageCfgObj.getInstance().getByIndex("11034"), true);
            this._bookView = new VMCView();
            this._bookView.auto = true;
            this._bookView.move(190, 300);
            addChild(this._bookView);
            this._magicNum = new ImgNumber();
            this._magicNum.move(110, 68);
            addChild(this._magicNum);
            this._attackSpeedTxt = getDisplayChildByName("attackSpeedTxt");
            this._attackPowerTxt = getDisplayChildByName("attackPowerTxt");
            this._skillBoxMask = getDisplayChildByName("skillBoxMask");
            this._skillBoxes = new HBox();
            this._skillBoxes.mask = getDisplayChildByName("skillboxMask");
            this._skillBoxes.oneRow = 9;
            this._skillBoxes.horizontal = true;
            this._skillBoxes.intervalX = 12;
            addChild(this._skillBoxes);
            this._skillBoxes.move(75, 432);
            this._starBoxes = new HBox();
            this._starBoxes.move(53, 74);
            this._starBoxes.horizontal = true;
            this._starBoxes.intervalX = 3;
            addChild(this._starBoxes);
            var _loc_2:* = 0;
            while (_loc_2 < STAR_NUM)
            {
                
                _loc_1 = ToolKit.getNew("magicotherPanel_star");
                _loc_1.gotoAndStop(2);
                this._starBoxes.add(_loc_1);
                _loc_2++;
            }
            return;
        }// end function

        private function setStarLight(param1:int) : void
        {
            var _loc_2:* = 0;
            if (param1 > STAR_NUM && param1 < 1)
            {
                Log.error("MagicBook:" + param1 + "星星数组越界");
            }
            else
            {
                _loc_2 = 0;
                while (_loc_2 < STAR_NUM)
                {
                    
                    if (_loc_2 < param1)
                    {
                        (this._starBoxes.getContent(_loc_2) as MovieClip).gotoAndStop(1);
                    }
                    else
                    {
                        (this._starBoxes.getContent(_loc_2) as MovieClip).gotoAndStop(2);
                    }
                    _loc_2++;
                }
            }
            return;
        }// end function

        private function addEvents() : void
        {
            addEvtListener(MouseEvent.CLICK, this.__click);
            this._playerMagicInfo.addEvtListener(MagicBookEvent.UPDATE_OTHER_INFO, this.updateUI);
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btn1:
                {
                    ChatController.getInstance().toRole(OtherRoleControl.getInstance().playerInfo.name);
                    break;
                }
                case this.btn2:
                {
                    TeamControl.getInstance().teamInvitePlayer(OtherRoleControl.getInstance().playerInfo.personId);
                    break;
                }
                case this.btn3:
                {
                    TeamControl.getInstance().teamInvitePlayer(OtherRoleControl.getInstance().playerInfo.personId);
                    break;
                }
                case this.btn4:
                {
                    if (OtherRoleControl.getInstance().playerInfo.personId && UserObj.getInstance().playerInfo.guildId)
                    {
                        GuildControl.getInstance().reqGuildInviteAdd(UserObj.getInstance().playerInfo.guildId, OtherRoleControl.getInstance().playerInfo.personId);
                    }
                    else if (OtherRoleControl.getInstance().playerInfo.guildId)
                    {
                        GuildControl.getInstance().reqGuildApplyAdd(OtherRoleControl.getInstance().playerInfo.guildId);
                    }
                    break;
                }
                case this._btnLeftRot:
                {
                    this.setNestDirect(1);
                    break;
                }
                case this._btnRightRot:
                {
                    this.setNestDirect(-1);
                    break;
                }
                case this._turnleftBtn:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.currentSkillIndex - 1;
                    _loc_2.currentSkillIndex = _loc_3;
                    this.updateTurnBtn();
                    this.doMove();
                    break;
                }
                case this._turnrighttBtn:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.currentSkillIndex + 1;
                    _loc_2.currentSkillIndex = _loc_3;
                    this.updateTurnBtn();
                    this.doMove();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setNestDirect(param1:int = 0) : void
        {
            if (!this._bookView)
            {
                return;
            }
            switch(param1)
            {
                case -1:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._modelDir - 1;
                    _loc_2._modelDir = _loc_3;
                    this._modelDir = this._modelDir < -3 ? (4) : (this._modelDir);
                    break;
                }
                case 0:
                {
                    break;
                }
                case 1:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._modelDir + 1;
                    _loc_2._modelDir = _loc_3;
                    this._modelDir = this._modelDir > 4 ? (-3) : (this._modelDir);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.loadModelRes(this._modelDir);
            return;
        }// end function

        private function loadModelRes(param1:int) : void
        {
            var l:int;
            var cfgBook:QMagicBookCfg;
            var url:String;
            var direct:* = param1;
            var info:* = OtherRoleControl.getInstance().playerInfo;
            if (info)
            {
                if (this._bookView)
                {
                    if (info.magicBook)
                    {
                        l = info.magicBook.level;
                    }
                    else
                    {
                        l;
                    }
                    cfgBook = QMagicbookLevelCfg.getInstance().getMagicBookCfg(l);
                    url = cfgBook.panelModelUrl;
                    this._bookView.direct = direct * 45;
                    this._bookView.loadRes(url, null, false, function () : void
            {
                _bookView.updatePose(Math.abs(direct * 45).toString(), true);
                return;
            }// end function
            );
                }
            }
            return;
        }// end function

        public function updateUI(event:MagicBookEvent = null) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!UILoaded || OtherRoleControl.getInstance().playerInfo == null)
            {
                return;
            }
            _loc_2 = MagicBookData.getOtherMagicInfo();
            this.loadModelRes(this._modelDir);
            if (!_loc_2.getMagicAttrInfo(MagicBookPropertyType.ATTACK_SPEED))
            {
                return;
            }
            this._attackSpeedTxt.htmlText = _loc_2.getMagicAttrInfo(MagicBookPropertyType.ATTACK_SPEED).attrValue.toString();
            this._attackPowerTxt.htmlText = _loc_2.getMagicAttrInfo(MagicBookPropertyType.ATK_MIN).attrValue.toString() + "-" + _loc_2.getMagicAttrInfo(MagicBookPropertyType.ATK_MAX).attrValue.toString();
            this.allSkillnum = _loc_2.skills_m.length;
            this._skillBoxes.reset();
            var _loc_5:* = 0;
            while (_loc_5 < 8)
            {
                
                _loc_4 = new MagicBookSkillBox("magicotherPanel_skillBox");
                if (_loc_5 < this.allSkillnum)
                {
                    _loc_3 = MagicBookSkillCfgObj.getInstance().getMagicSkillInfoByServer(_loc_2.skills_m[_loc_5]);
                    _loc_4.setInfo(_loc_3);
                }
                else
                {
                    _loc_4.setInfo(null);
                }
                this._skillBoxes.add(_loc_4);
                _loc_5++;
            }
            this.currentSkillIndex = 0;
            this.updateTurnBtn();
            this.setStarLight(_loc_2.getMagicStar());
            return;
        }// end function

        private function doMove() : void
        {
            TweenLite.to(this._skillBoxes, 0.3, {x:75 - 60 * this.currentSkillIndex});
            return;
        }// end function

        private function updateTurnBtn() : void
        {
            if (this.currentSkillIndex == 0)
            {
                this._turnleftBtn.visible = false;
            }
            else
            {
                this._turnleftBtn.visible = true;
            }
            if (this.allSkillnum - this.currentSkillIndex < 5)
            {
                this._turnrighttBtn.visible = false;
            }
            else
            {
                this._turnrighttBtn.visible = true;
            }
            return;
        }// end function

    }
}
