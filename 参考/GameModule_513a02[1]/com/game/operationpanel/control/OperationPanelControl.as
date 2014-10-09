package com.game.operationpanel.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.events.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.operationpanel.view.*;
    import com.game.primaryrole.control.*;
    import com.game.shortcut.bean.*;
    import com.game.shortcut.control.*;
    import com.model.*;
    import com.model.vo.*;

    public class OperationPanelControl extends Object
    {
        private var _panel:OperationBottomBar;
        private var _weiduanPanel:LoadWeiDuanPanel;
        private static var _instance:OperationPanelControl;

        public function OperationPanelControl()
        {
            UserObj.getInstance().playerInfo.addEvtListener(RoleEvent.UPDATE_UNALLOCALTEDTALENT, this.__unlocatePoint);
            return;
        }// end function

        public function get panel() : OperationBottomBar
        {
            if (!this._panel)
            {
                this._panel = new OperationBottomBar();
            }
            return this._panel;
        }// end function

        public function getSkillGridEmpty(param1:SkillInfo) : ShortcutBox
        {
            if (this._panel)
            {
                return this._panel.getSkillGridEmpty(param1);
            }
            return null;
        }// end function

        public function getSkillGrid(param1:int) : ShortcutBox
        {
            if (this._panel)
            {
                return this._panel.getSkillGrid(param1);
            }
            return null;
        }// end function

        public function getSkillGridBySkillId(param1:int) : ShortcutBox
        {
            if (this._panel)
            {
                return this._panel.getSkillGridBySkillId(param1);
            }
            return null;
        }// end function

        public function openWeiDuanPanel() : void
        {
            var _loc_1:* = null;
            if (!this._weiduanPanel)
            {
                this._weiduanPanel = new LoadWeiDuanPanel();
                _loc_1 = new LayoutInfo(Layout.CENTER, 0, -35);
                Global.popManager.addPop(this._weiduanPanel, false, false, false, true, false, false, _loc_1);
            }
            this._weiduanPanel.openOrClose();
            return;
        }// end function

        public function getSkillBtn() : BaseButton
        {
            if (this._panel)
            {
                return this._panel.skillBtn;
            }
            return null;
        }// end function

        public function getBtnForName(param1:String) : BaseButton
        {
            return this.panel.getOperatBtn(param1);
        }// end function

        public function setItemCD(param1:int) : void
        {
            var _loc_2:* = new PropInfo();
            _loc_2.convByCfg(param1);
            if (_loc_2 && _loc_2.q_type == 2)
            {
                if (this._panel)
                {
                    this._panel.setItemCD(_loc_2);
                }
            }
            return;
        }// end function

        public function shortCutAdd(param1:ShortCutInfo) : void
        {
            this.panel.shortCurAdd(param1);
            return;
        }// end function

        public function shortCutRemove(param1:int) : void
        {
            this.panel.shortCutRemove(param1);
            return;
        }// end function

        public function shortcutInfos() : void
        {
            return;
        }// end function

        public function freshShortCutView() : void
        {
            var _loc_1:* = ShortcutControl.getInstance().getShortcutInfos();
            this.panel.updateShortCut(_loc_1);
            return;
        }// end function

        public function flickerBtn(param1:String) : void
        {
            if (this._panel)
            {
                this._panel.flickerBtn(param1);
            }
            return;
        }// end function

        private function __unlocatePoint(event:RoleEvent) : void
        {
            if (UserObj.getInstance().playerInfo.unallocatedTalent > 0 && UserObj.getInstance().playerInfo.level < 120 && GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().ROLE_POINT_ACTIVE_TEAM)) == 1)
            {
                if (!PrimaryRoleControl.getInstance().isRoleTalentPlusPanelOpen())
                {
                    GuideControl.getInstance().beginGuide(int(GuideConfigObj.getInstance().ROLE_POINT_SY_TEAM));
                    OperationPanelControl.getInstance().flickerBtn("role");
                }
            }
            return;
        }// end function

        public function showOrHideGuildChatIcon(param1:Boolean) : void
        {
            if (this.panel && this.panel.UILoaded)
            {
                this.panel.showOrHideGuildChatIcon(param1);
            }
            return;
        }// end function

        public function filterGuildChatIcon(param1:Boolean) : void
        {
            if (this.panel && this.panel.UILoaded)
            {
                this.panel.filterGuildChatIcon(param1);
            }
            return;
        }// end function

        public function setBarEnable(param1:Boolean) : void
        {
            if (this._panel)
            {
                this._panel.setBarEnable(param1);
            }
            return;
        }// end function

        public static function getInstance() : OperationPanelControl
        {
            if (!_instance)
            {
                _instance = new OperationPanelControl;
            }
            return _instance;
        }// end function

    }
}
