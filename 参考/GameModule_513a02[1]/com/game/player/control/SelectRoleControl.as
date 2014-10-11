package com.game.player.control
{
    import com.*;
    import com.events.*;
    import com.game.player.view.*;
    import com.game.role.model.*;
    import com.game.role.util.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;

    public class SelectRoleControl extends Object
    {
        private var _selectRoleBox:SelectRoleBox;
        private var _selectMonsterBox:SelectMonsterBox;
        private var _selectBossBox:SelectBossBox;
        public var hasInit:Boolean = false;
        public var hasInitRole:Boolean = false;
        public var hasInitMonster:Boolean = false;
        public var hasInitBoss:Boolean = false;
        private static var _instance:SelectRoleControl;

        public function SelectRoleControl()
        {
            UserObj.getInstance().addEvtListener(GameEvent.CHANGE_SELECT_ROLE, this.changeSelectHandler);
            return;
        }// end function

        public function get selectRoleBox() : SelectRoleBox
        {
            if (!this._selectRoleBox)
            {
                this._selectRoleBox = new SelectRoleBox();
                this._selectRoleBox.visible = false;
                this._selectRoleBox.x = 350;
                Global.mainUIManager.addUI(this._selectRoleBox, null, GroupPanelType.GROUP_LOW);
                this.hasInitRole = true;
                this.hasInit = true;
            }
            return this._selectRoleBox;
        }// end function

        public function get selectMonsterBox() : SelectMonsterBox
        {
            if (!this._selectMonsterBox)
            {
                this._selectMonsterBox = new SelectMonsterBox();
                this._selectMonsterBox.visible = false;
                this._selectMonsterBox.x = 350 + 70;
                Global.mainUIManager.addUI(this._selectMonsterBox, null, GroupPanelType.GROUP_LOW);
                Global.mainUIManager.addUI(this._selectMonsterBox, null);
                this.hasInitMonster = true;
                this.hasInit = true;
            }
            return this._selectMonsterBox;
        }// end function

        public function get selectBossBox() : SelectBossBox
        {
            if (!this._selectBossBox)
            {
                this._selectBossBox = new SelectBossBox();
                this._selectBossBox.visible = false;
                this._selectBossBox.x = 350 + 70;
                Global.mainUIManager.addUI(this._selectBossBox, null, GroupPanelType.GROUP_LOW);
                Global.mainUIManager.addUI(this._selectBossBox, null);
                this.hasInitBoss = true;
                this.hasInit = true;
            }
            return this._selectBossBox;
        }// end function

        private function changeSelectHandler(event:GameEvent) : void
        {
            if (!event.obj)
            {
                return;
            }
            if (UserObj.getInstance().selectRole && UserObj.getInstance().selectRole.info is PlayerInfo)
            {
                var _loc_2:* = false;
                this.selectMonsterBox.visible = false;
                var _loc_2:* = false;
                this.selectBossBox.visible = false;
                this.selectRoleBox.visible = true;
                if (RoleLevelUtil.isMasterLevel(UserObj.getInstance().playerInfo.level))
                {
                    this.selectRoleBox.x = 350 + 70;
                }
                else
                {
                    this.selectRoleBox.x = 350;
                }
                this.selectRoleBox.setInfo(UserObj.getInstance().selectRole.info);
            }
            else if (UserObj.getInstance().selectRole && UserObj.getInstance().selectRole.info is MonsterInfo && UserObj.getInstance().selectRole.info.monster_type == MonsterType.MONSTER_CREAM)
            {
                var _loc_2:* = false;
                this.selectRoleBox.visible = false;
                var _loc_2:* = false;
                this.selectBossBox.visible = false;
                this.selectMonsterBox.setInfo(UserObj.getInstance().selectRole.info);
            }
            else if (UserObj.getInstance().selectRole && UserObj.getInstance().selectRole.info is MonsterInfo && UserObj.getInstance().selectRole.info.monster_type == MonsterType.MONSTER_BOSS)
            {
                var _loc_2:* = false;
                this.selectRoleBox.visible = false;
                var _loc_2:* = false;
                this.selectMonsterBox.visible = false;
                this.selectBossBox.setInfo(UserObj.getInstance().selectRole.info);
            }
            else
            {
                var _loc_2:* = false;
                this.selectRoleBox.visible = false;
                var _loc_2:* = false;
                this.selectMonsterBox.visible = false;
                var _loc_2:* = false;
                this.selectBossBox.visible = false;
            }
            return;
        }// end function

        public static function getInstance() : SelectRoleControl
        {
            if (_instance == null)
            {
                _instance = new SelectRoleControl;
            }
            return _instance;
        }// end function

    }
}
