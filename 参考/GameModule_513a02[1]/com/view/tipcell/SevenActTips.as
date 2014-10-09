package com.view.tipcell
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.newactivity.message.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;

    public class SevenActTips extends BaseTips
    {
        private var _info:NewActivityItemInfo;
        private var _content:MovieClip;
        private var NO_DATA:String;
        private var NOT_TOP_100:String;

        public function SevenActTips()
        {
            this.NO_DATA = LanguageCfgObj.getInstance().getByIndex("10146");
            this.NOT_TOP_100 = LanguageCfgObj.getInstance().getByIndex("10147");
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            this._info = param1 as NewActivityItemInfo;
            FrameworkGlobal.addMsgListen(NewActivityEvent.NEW_ACT_RANK_INFO_UPDATE, this.rankInfoUpdate);
            return;
        }// end function

        private function rankInfoUpdate(event:NewActivityEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_2:* = event.data as ResGetRankInfoMessage;
            if (this._info && this._info.activityId == _loc_2.activityId)
            {
                _loc_3 = 0;
                if (this._info.activityId == NewActivityConfig.ACTID_SEVEN_ACTIVITY_3 || this._info.activityId == NewActivityConfig.ACTID_WAR2_MERGE || this._info.activityId == NewActivityConfig.ACTID_WAR4_MERGE)
                {
                    this._content = ToolKit.getNew("sevenAct_guildTips") as MovieClip;
                    if (_loc_2.infoList.length > 0)
                    {
                        this._content.guildName.htmlText = _loc_2.infoList[0].data;
                        this._content.guildLeaderName.htmlText = _loc_2.infoList[0].playerName;
                    }
                    else
                    {
                        this._content.guildName.htmlText = LanguageCfgObj.getInstance().getByIndex("10146");
                        this._content.guildLeaderName.htmlText = LanguageCfgObj.getInstance().getByIndex("10146");
                    }
                }
                else if (this._info.index == 0)
                {
                    this._content = ToolKit.getNew("sevenAct_firstTips") as MovieClip;
                    switch(this._info.activityId)
                    {
                        case NewActivityConfig.ACTID_SEVEN_ACTIVITY_2:
                        {
                            this._content.rankTitle.htmlText = LanguageCfgObj.getInstance().getByIndex("10150");
                            break;
                        }
                        case NewActivityConfig.ACTID_SEVEN_ACTIVITY_4:
                        {
                            this._content.rankTitle.htmlText = LanguageCfgObj.getInstance().getByIndex("10151");
                            break;
                        }
                        case NewActivityConfig.ACTID_SEVEN_ACTIVITY_5:
                        {
                            this._content.rankTitle.htmlText = LanguageCfgObj.getInstance().getByIndex("10152");
                            break;
                        }
                        case NewActivityConfig.ACTID_SEVEN_ACTIVITY_6:
                        {
                            this._content.rankTitle.htmlText = LanguageCfgObj.getInstance().getByIndex("10153");
                            break;
                        }
                        case NewActivityConfig.ACTID_SEVEN_ACTIVITY_7:
                        {
                            this._content.rankTitle.htmlText = LanguageCfgObj.getInstance().getByIndex("10154");
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (_loc_2.infoList.length > 0)
                    {
                        switch(this._info.activityId)
                        {
                            case NewActivityConfig.ACTID_SEVEN_ACTIVITY_2:
                            {
                                break;
                            }
                            case NewActivityConfig.ACTID_SEVEN_ACTIVITY_4:
                            {
                                break;
                            }
                            case NewActivityConfig.ACTID_SEVEN_ACTIVITY_5:
                            {
                                break;
                            }
                            case NewActivityConfig.ACTID_SEVEN_ACTIVITY_6:
                            {
                                break;
                            }
                            case NewActivityConfig.ACTID_SEVEN_ACTIVITY_7:
                            {
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        _loc_6 = _loc_2.infoList.length - 1;
                        switch(this._info.activityId)
                        {
                            case NewActivityConfig.ACTID_SEVEN_ACTIVITY_2:
                            {
                                break;
                            }
                            case NewActivityConfig.ACTID_SEVEN_ACTIVITY_4:
                            {
                                break;
                            }
                            case NewActivityConfig.ACTID_SEVEN_ACTIVITY_5:
                            {
                                break;
                            }
                            case NewActivityConfig.ACTID_SEVEN_ACTIVITY_6:
                            {
                                break;
                            }
                            case NewActivityConfig.ACTID_SEVEN_ACTIVITY_7:
                            {
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                    }
                    else
                    {
                        this._content.playerName.htmlText = this.NO_DATA;
                        this._content.myRank.htmlText = this.NOT_TOP_100;
                        this._content.job.text = "";
                        this._content.lv.text = "";
                        this._content.myName.text = "";
                        this._content.myJob.text = "";
                        this._content.myLv.text = "";
                    }
                }
                else
                {
                    this._content = ToolKit.getNew("sevenAct_secondTips") as MovieClip;
                    switch(this._info.activityId)
                    {
                        case NewActivityConfig.ACTID_SEVEN_ACTIVITY_2:
                        {
                            this._content.rankTitle1.htmlText = LanguageCfgObj.getInstance().getByIndex("10156");
                            this._content.rankTitle2.htmlText = LanguageCfgObj.getInstance().getByIndex("10157");
                            break;
                        }
                        case NewActivityConfig.ACTID_SEVEN_ACTIVITY_4:
                        {
                            this._content.rankTitle1.htmlText = LanguageCfgObj.getInstance().getByIndex("10158");
                            this._content.rankTitle2.htmlText = LanguageCfgObj.getInstance().getByIndex("10159");
                            break;
                        }
                        case NewActivityConfig.ACTID_SEVEN_ACTIVITY_5:
                        {
                            this._content.rankTitle1.htmlText = LanguageCfgObj.getInstance().getByIndex("10160");
                            this._content.rankTitle2.htmlText = LanguageCfgObj.getInstance().getByIndex("10161");
                            break;
                        }
                        case NewActivityConfig.ACTID_SEVEN_ACTIVITY_6:
                        {
                            this._content.rankTitle1.htmlText = LanguageCfgObj.getInstance().getByIndex("10162");
                            this._content.rankTitle2.htmlText = LanguageCfgObj.getInstance().getByIndex("10163");
                            break;
                        }
                        case NewActivityConfig.ACTID_SEVEN_ACTIVITY_7:
                        {
                            this._content.rankTitle1.htmlText = LanguageCfgObj.getInstance().getByIndex("10164");
                            this._content.rankTitle2.htmlText = LanguageCfgObj.getInstance().getByIndex("10165");
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (_loc_2.infoList.length > 0)
                    {
                        _loc_4 = _loc_2.infoList.length - 2;
                        switch(this._info.activityId)
                        {
                            case NewActivityConfig.ACTID_SEVEN_ACTIVITY_2:
                            {
                                break;
                            }
                            case NewActivityConfig.ACTID_SEVEN_ACTIVITY_4:
                            {
                                break;
                            }
                            case NewActivityConfig.ACTID_SEVEN_ACTIVITY_5:
                            {
                                break;
                            }
                            case NewActivityConfig.ACTID_SEVEN_ACTIVITY_6:
                            {
                                break;
                            }
                            case NewActivityConfig.ACTID_SEVEN_ACTIVITY_7:
                            {
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        _loc_3 = 0;
                        while (_loc_3 < _loc_4)
                        {
                            
                            this._content["playerName" + _loc_3].htmlText = _loc_2.infoList[(_loc_3 + 1)].playerName;
                            switch(this._info.activityId)
                            {
                                case NewActivityConfig.ACTID_SEVEN_ACTIVITY_2:
                                {
                                    this._content["job" + _loc_3].htmlText = JobType.getJobName(_loc_2.infoList[(_loc_3 + 1)].job);
                                    this._content["lv" + _loc_3].htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11817"), [_loc_2.infoList[(_loc_3 + 1)].data]);
                                    break;
                                }
                                case NewActivityConfig.ACTID_SEVEN_ACTIVITY_4:
                                {
                                    _loc_7 = ZonesCloneCfg.getInstance().getZonesInfoFromId(int(_loc_2.infoList[(_loc_3 + 1)].data));
                                    this._content["job" + _loc_3].htmlText = _loc_7.duplicate_name;
                                    this._content["lv" + _loc_3].text = "";
                                    break;
                                }
                                case NewActivityConfig.ACTID_SEVEN_ACTIVITY_5:
                                {
                                    this._content["playerName" + _loc_3].htmlText = _loc_2.infoList[(_loc_3 + 1)].playerName;
                                    this._content["job" + _loc_3].text = "";
                                    this._content["lv" + _loc_3].text = "";
                                    break;
                                }
                                case NewActivityConfig.ACTID_SEVEN_ACTIVITY_6:
                                {
                                    _loc_5 = HorseCfgObj.getInstance().getInfoFromLevel(int(_loc_2.infoList[(_loc_3 + 1)].data));
                                    this._content["job" + _loc_3].htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11818"), [_loc_5.horse_step, _loc_5.horse_step_level]);
                                    this._content["lv" + _loc_3].text = "";
                                    break;
                                }
                                case NewActivityConfig.ACTID_SEVEN_ACTIVITY_7:
                                {
                                    this._content["job" + _loc_3].htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11819"), [_loc_2.infoList[(_loc_3 + 1)].data]);
                                    this._content["lv" + _loc_3].text = "";
                                    break;
                                }
                                default:
                                {
                                    break;
                                }
                            }
                            _loc_3++;
                        }
                        while (_loc_3 <= 18)
                        {
                            
                            this._content["playerName" + _loc_3].htmlText = this.NO_DATA;
                            this._content["job" + _loc_3].text = "";
                            this._content["lv" + _loc_3].text = "";
                            _loc_3++;
                        }
                    }
                    else
                    {
                        this._content.myRank.htmlText = this.NOT_TOP_100;
                        this._content.myName.text = "";
                        this._content.myJob.text = "";
                        this._content.myLv.text = "";
                        while (_loc_3 <= 18)
                        {
                            
                            this._content["playerName" + _loc_3].htmlText = this.NO_DATA;
                            this._content["job" + _loc_3].text = "";
                            this._content["lv" + _loc_3].text = "";
                            _loc_3++;
                        }
                    }
                }
                addChild(this._content);
            }
            return;
        }// end function

        override public function remove() : void
        {
            FrameworkGlobal.removeMsgListen(NewActivityEvent.NEW_ACT_RANK_INFO_UPDATE, this.rankInfoUpdate);
            return;
        }// end function

    }
}
