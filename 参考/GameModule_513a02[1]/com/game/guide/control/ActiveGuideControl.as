package com.game.guide.control
{
    import com.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.game.artifact.control.*;
    import com.game.card.model.*;
    import com.game.gm.message.*;
    import com.game.gradegift.control.*;
    import com.game.guide.model.*;
    import com.game.guide.view.*;
    import com.game.horse.control.*;
    import com.game.magicbook.model.*;
    import com.game.map.control.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.newactivity.model.*;
    import com.game.task.*;
    import com.game.task.events.*;
    import com.game.task.model.*;
    import com.game.zones.model.*;
    import com.model.*;
    import com.staticdata.*;

    public class ActiveGuideControl extends Object
    {
        private var _panel:ActiveGuidePanel;
        private var _layoutInfo:LayoutInfo;
        private static var _instance:ActiveGuideControl;

        public function ActiveGuideControl()
        {
            TaskGlobal.myEvt.addEventListener(TaskEvent.GET_NEW_TASK, this.completeTask);
            UserObj.getInstance().playerInfo.addEventListener(RoleEvent.UPDATE_LEVEL, this.playerLevelUpdate);
            return;
        }// end function

        public function open(param1:int) : void
        {
            var _loc_2:* = TaskCfgObj.getInstance().getActiveConfig(param1);
            this.openByActiveConfig(_loc_2);
            return;
        }// end function

        public function openByLv(param1:int) : void
        {
            var _loc_2:* = TaskCfgObj.getInstance().getActiveConfigByLevel(param1);
            this.openByActiveConfig(_loc_2);
            return;
        }// end function

        public function openByTeamId(param1:String, param2:Boolean = false) : void
        {
            var _loc_3:* = TaskCfgObj.getInstance().getActiveConfigByTeam(param1);
            this.openByActiveConfig(_loc_3, param2);
            return;
        }// end function

        public function resGMOpenIcon(param1:ResGMOpenIconMessage) : void
        {
            this.openByTeamId(param1.iconNum.toString(), true);
            return;
        }// end function

        private function openByActiveConfig(param1:Object, param2:Boolean = false) : void
        {
            if (param1)
            {
                if (!param2 && GuideConfigObj.getInstance().getGuideConfig(int(param1.q_guide_team_id)) != 0)
                {
                    return;
                }
                if (FrameworkGlobal.language == "ft")
                {
                    if (param1.q_guide_team_id == GuideConfigObj.getInstance().BOSS_HOME || param1.q_guide_team_id == GuideConfigObj.getInstance().SUIT_OPT_TEAM)
                    {
                        return;
                    }
                }
                GuideConfigObj.getInstance().saveConfigByTeam(int(param1.q_guide_team_id), 2);
                switch(param1.q_guide_team_id)
                {
                    case GuideConfigObj.getInstance().HORSE_ACTIVE_TEAM:
                    {
                        HorseControl.getInstance().reqHorseReceive();
                        break;
                    }
                    case GuideConfigObj.getInstance().ARTIFACT_ACTIVE_TEAM:
                    {
                        ArtifactControl.getInstance().enableArtifact();
                        break;
                    }
                    case GuideConfigObj.getInstance().ROLE_POINT_ACTIVE_TEAM:
                    {
                        GuideConfigObj.getInstance().isRolePointActiveing = true;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (!this._panel)
                {
                    this._panel = new ActiveGuidePanel();
                    if (!this._layoutInfo)
                    {
                        this._layoutInfo = new LayoutInfo(Layout.CENTER);
                    }
                    Global.popManager.addPop(this._panel, true, true, true, false, false, false, this._layoutInfo);
                }
                this._panel.info = param1;
                this._panel.open();
            }
            return;
        }// end function

        public function close() : void
        {
            if (this._panel)
            {
                this._panel.close();
            }
            return;
        }// end function

        private function completeTask(event:TaskEvent) : void
        {
            this.open(TaskMsgVO(event.data).taskId);
            return;
        }// end function

        private function playerLevelUpdate(event:RoleEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = TopActivateCfgObj.getInstance().getButtonByLevel(UserObj.getInstance().playerInfo.level);
            if (_loc_2 && _loc_2.length)
            {
                for each (_loc_3 in _loc_2)
                {
                    
                    if (!MapControl.getInstance().hasTopBtn(_loc_3) && this.filter(_loc_3))
                    {
                        MapControl.getInstance().addedToTopIcon(_loc_3);
                        MapControl.getInstance().showFuncEffect(_loc_3);
                    }
                }
            }
            this.openByLv(UserObj.getInstance().playerInfo.level);
            _loc_2 = TaskCfgObj.getInstance().getForceButtonByLevel();
            if (_loc_2 && _loc_2.length)
            {
                for each (_loc_4 in _loc_2)
                {
                    
                    if (_loc_4.q_guide_team_id && _loc_4.q_guide_team_id != "")
                    {
                        this.openByActiveConfig(_loc_4);
                    }
                }
            }
            return;
        }// end function

        private function filter(param1:String) : Boolean
        {
            var _loc_2:* = false;
            var _loc_3:* = false;
            switch(param1)
            {
                case TopActivateName.TOP_ICON_LINK_TO_DESKTOP:
                {
                    return !(LoginType.WEIDUAN == Params.loginType || Params.wdType == WeiDuanType.NO_WEIDUAN);
                }
                case TopActivateName.TOP_ICON_CARD_PHONE:
                {
                    _loc_2 = PlayerConfig.getInstance().getValue(PlayerConfig.PHONE_VERIFY_CLICK) != 0;
                    return !(_loc_2 || CardData.getInstance().state > 1 || Params.pvType == PhoneVerifyType.NO_VERIFY);
                }
                case TopActivateName.TOP_ICON_WOLF_SOUL:
                {
                    return ZonesModel.getInstance().isWolfSoulAct;
                }
                case TopActivateName.TOP_ICON_LEVEL_GIFT:
                {
                    if (GradeGiftControl.getInstance().gradeGiftInfo == null || GradeGiftControl.getInstance().gradeGiftInfo.surplusTime < 0)
                    {
                        return false;
                    }
                    return true;
                }
                case TopActivateName.TOP_ICON_SINGLE_RECHARGE:
                {
                    if (NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_SINGLE_RECHARGE))
                    {
                        return true;
                    }
                    return false;
                }
                case TopActivateName.TOP_ICON_MAY_ACTIVITY:
                {
                    if (NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_MAY_ACTIVITY_5))
                    {
                        return true;
                    }
                    return false;
                }
                case TopActivateName.TOP_ICON_CLOUD_BUY:
                {
                    return false;
                }
                case TopActivateName.SUPERVIP:
                {
                    return false;
                }
                case TopActivateName.FACEBOOK_INVITE:
                {
                    return NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_FACEBOOK_INVITE) != null;
                }
                case TopActivateName.FACEBOOK_SHARE:
                {
                    return NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_FACEBOOK_SHARE) != null;
                }
                case TopActivateName.MERGE_SERVICE:
                {
                    if (NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_FIVE_LOGIN_MERGE))
                    {
                        return true;
                    }
                    if (NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_WAR2_MERGE))
                    {
                        return true;
                    }
                    if (NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_WAR4_MERGE))
                    {
                        return true;
                    }
                    return false;
                }
                case TopActivateName.PREV_MERGE:
                {
                    if (NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_PREV_MERGE))
                    {
                        return true;
                    }
                    return false;
                }
                case TopActivateName.TOP_ICON_MID_AUTUMN:
                {
                    if (NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_MID_AUTUMN))
                    {
                        return true;
                    }
                    return false;
                }
                case TopActivateName.TOP_ICON_PERSONAL_INFORMATION:
                {
                    if (!(Params.isadult == AdultType.ADULT_NOT_COMPLET || Params.isadult == AdultType.ADULT_NOT_COMPLET))
                    {
                        return false;
                    }
                    return true;
                }
                case TopActivateName.TOP_ICON_MAGIC_BOOK:
                {
                    return MagicBookData.isShowIcon();
                }
                case TopActivateName.TOP_ICON_MOOD_FEASTIVAL:
                {
                    if (NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_MOONFESTIVAL_1))
                    {
                        return true;
                    }
                    return false;
                }
                case TopActivateName.TOP_ICON_POPULAR:
                {
                    if (NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_POPULAR_PAY))
                    {
                        return true;
                    }
                    return false;
                }
                default:
                {
                    break;
                }
            }
            return true;
        }// end function

        public static function getInstance() : ActiveGuideControl
        {
            var _loc_1:* = new ActiveGuideControl;
            _instance = new ActiveGuideControl;
            return _instance || _loc_1;
        }// end function

    }
}
