package com.game.toplist.view
{
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.artifact.cfg.*;
    import com.game.role.view.*;
    import com.game.toplist.cfg.*;
    import com.game.toplist.control.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class TopListSelectItem extends BaseButton
    {
        private var _cell:int;
        private var back:MovieClip;
        private var mc_rank:MovieClip;
        private var crownMc:MovieClip;
        private var rankTxt:TextField;
        private var nameTxt:TextField;
        private var jobTxt:TextField;
        private var scoreTxt:TextField;
        private var txtLevIcon:RoleLevelIcon;

        public function TopListSelectItem(param1, param2:int)
        {
            super(param1);
            this._cell = param2;
            this.back = getDisplayChildByName("back");
            this.back.gotoAndStop(this._cell % 2 + 1);
            this.mc_rank = getDisplayChildByName("mc_rank");
            this.crownMc = getDisplayChildByName("crownMc");
            this.rankTxt = getDisplayChildByName("rankTxt");
            this.nameTxt = getDisplayChildByName("nameTxt");
            this.jobTxt = getDisplayChildByName("jobTxt");
            this.scoreTxt = getDisplayChildByName("scoreTxt");
            this.txtLevIcon = new RoleLevelIcon();
            this.txtLevIcon.x = this.scoreTxt.x;
            this.txtLevIcon.y = this.scoreTxt.y;
            this.txtLevIcon.textColor = this.scoreTxt.textColor;
            this.scoreTxt.parent.addChild(this.txtLevIcon);
            addEvtListener(MouseEvent.MOUSE_OVER, this.mouseOverHandler);
            addEvtListener(MouseEvent.MOUSE_OUT, this.mouseOutHandler);
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            return;
        }// end function

        override public function set selected(param1:Boolean) : void
        {
            super.selected = param1;
            enabled = !param1;
            this.back.gotoAndStop(param1 ? (4) : (this._cell % 2 + 1));
            return;
        }// end function

        protected function mouseOverHandler(event:MouseEvent) : void
        {
            if (selected)
            {
                return;
            }
            this.back.gotoAndStop(3);
            return;
        }// end function

        protected function mouseOutHandler(event:MouseEvent) : void
        {
            if (selected)
            {
                return;
            }
            this.back.gotoAndStop(this._cell % 2 + 1);
            return;
        }// end function

        override public function set obj(param1) : void
        {
            super.obj = param1;
            this.setInfo(param1);
            return;
        }// end function

        private function setInfo(param1:TopListInfo) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param1)
            {
                if (param1.topidx == 0)
                {
                    visible = false;
                    this.mc_rank.gotoAndStop(4);
                    this.crownMc.gotoAndStop(4);
                    this.rankTxt.text = "";
                    if (TopListControl.getInstance().currentType == TopCfg.LABOUR_TYPE)
                    {
                        this.nameTxt.text = LanguageCfgObj.getInstance().getByIndex("11372");
                    }
                    else
                    {
                        this.nameTxt.text = LanguageCfgObj.getInstance().getByIndex("11373");
                    }
                    this.jobTxt.text = "";
                    this.scoreTxt.text = "";
                    this.txtLevIcon.level = 0;
                    return;
                }
                else if (param1.topidx > 0 && param1.topidx < 4)
                {
                    this.mc_rank.gotoAndStop(param1.topidx);
                    this.crownMc.gotoAndStop(param1.topidx);
                    this.rankTxt.text = "";
                }
                else
                {
                    this.mc_rank.gotoAndStop(4);
                    this.crownMc.gotoAndStop(4);
                    this.rankTxt.text = param1.topidx + "";
                }
                switch(TopListControl.getInstance().currentType)
                {
                    case TopCfg.LEVEL_TYPE:
                    {
                        this.nameTxt.text = param1.playername;
                        this.jobTxt.text = JobType.getJobName(param1.job);
                        this.scoreTxt.text = "";
                        this.txtLevIcon.level = param1.level;
                        break;
                    }
                    case TopCfg.HORSE_TYPE:
                    {
                        this.nameTxt.text = param1.playername;
                        this.jobTxt.text = JobType.getJobName(param1.job);
                        _loc_2 = HorseCfgObj.getInstance().getInfoFromLevel(param1.horselevel, _loc_2);
                        if (_loc_2)
                        {
                            this.scoreTxt.text = StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("11374"), _loc_2.horse_step, _loc_2.horse_step_level);
                        }
                        else
                        {
                            this.scoreTxt.text = "";
                        }
                        this.txtLevIcon.level = 0;
                        break;
                    }
                    case TopCfg.COMBOS_TYPE:
                    {
                        this.nameTxt.text = param1.playername;
                        this.jobTxt.text = JobType.getJobName(param1.job);
                        this.scoreTxt.text = param1.maxEventcut + "";
                        this.txtLevIcon.level = 0;
                        break;
                    }
                    case TopCfg.FIGHT_FORCE_TYPE:
                    {
                        this.nameTxt.text = param1.playername;
                        this.jobTxt.text = JobType.getJobName(param1.job);
                        this.scoreTxt.text = param1.fightPower + "";
                        this.txtLevIcon.level = 0;
                        break;
                    }
                    case TopCfg.ARTIFACT_TYPE:
                    {
                        _loc_3 = ArtifactPropertyCfgObj.getInstance().getCfg(param1.alv);
                        this.nameTxt.text = param1.playername;
                        var _loc_5:* = JobType.getJobName(param1.job);
                        this.jobTxt.text = JobType.getJobName(param1.job);
                        this.jobTxt.text = _loc_5;
                        this.scoreTxt.text = _loc_3 ? (StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("12287"), _loc_3.q_step, _loc_3.q_client_level)) : (LanguageCfgObj.getInstance().getByIndex("12288"));
                        this.txtLevIcon.level = 0;
                        break;
                    }
                    case TopCfg.LABOUR_TYPE:
                    {
                        this.nameTxt.text = param1.guildinfo.guildName;
                        this.jobTxt.text = StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("11375"), param1.guildinfo.bannerLevel);
                        this.scoreTxt.text = param1.guildinfo.memberFightPower + "";
                        this.txtLevIcon.level = 0;
                        break;
                    }
                    case TopCfg.MAGIC_BOOK:
                    {
                        _loc_4 = QMagicbookLevelCfg.getInstance().getMagicBookCfg(param1.magicBookLevel);
                        this.nameTxt.text = param1.playername;
                        this.jobTxt.text = JobType.getJobName(param1.job);
                        this.scoreTxt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11818"), [_loc_4.getStar(), _loc_4.getMagicLevel()]);
                        this.txtLevIcon.level = 0;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                visible = true;
            }
            else
            {
                visible = false;
            }
            return;
        }// end function

    }
}
