package com.game.team.model
{
    import __AS3__.vec.*;
    import com.game.team.bean.*;
    import com.game.team.event.*;
    import com.game.team.message.*;
    import com.game.utils.*;
    import com.model.*;
    import flash.events.*;
    import net.*;

    public class TeamModel extends EventDispatcher
    {
        private var _captainId:long;
        private var _vecTeamInfo:Vector.<TeamMemberInfo>;
        public static const MAX_MEMBER_COUNT:int = 4;
        private static var _instance:TeamModel;

        public function TeamModel()
        {
            this._vecTeamInfo = new Vector.<TeamMemberInfo>;
            return;
        }// end function

        public function hasTeam() : Boolean
        {
            if (this.captainId && this.captainId.toNumber() > 0)
            {
                return true;
            }
            return false;
        }// end function

        public function addInfoToServer(param1:Message) : void
        {
            return;
        }// end function

        public function removeInfoFromServer(param1:Message) : void
        {
            return;
        }// end function

        public function get captainId() : long
        {
            return this._captainId;
        }// end function

        public function set captainId(param1:long) : void
        {
            this._captainId = param1;
            return;
        }// end function

        public function get teamId() : long
        {
            return UserObj.getInstance().playerInfo.teamId;
        }// end function

        public function get vecTeamInfo() : Vector.<TeamMemberInfo>
        {
            return this._vecTeamInfo;
        }// end function

        public function set vecTeamInfo(param1:Vector.<TeamMemberInfo>) : void
        {
            this._vecTeamInfo = param1;
            dispatchEvent(new TeamEvent(TeamEvent.TEAM_MEMBER_UPDATE));
            return;
        }// end function

        public function isTeamMember(param1:long) : TeamMemberInfo
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this._vecTeamInfo)
            {
                _loc_2 = this._vecTeamInfo.length;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    if (this._vecTeamInfo[_loc_3].memberid.equal(param1))
                    {
                        return this._vecTeamInfo[_loc_3];
                    }
                    _loc_3++;
                }
            }
            return null;
        }// end function

        public function updateTeamPos(param1:ResTeammateMoveToClientMessage) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this._vecTeamInfo)
            {
                _loc_2 = this._vecTeamInfo.length;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    if (this._vecTeamInfo[_loc_3].memberid.equal(param1.memberid))
                    {
                        this._vecTeamInfo[_loc_3].mx = param1.mx;
                        this._vecTeamInfo[_loc_3].my = param1.my;
                        break;
                    }
                    _loc_3++;
                }
            }
            return;
        }// end function

        public function getSelfInfo() : TeamMemberInfo
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_1:* = UserObj.getInstance().playerInfo.personId;
            if (this._vecTeamInfo)
            {
                _loc_2 = this._vecTeamInfo.length;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    if (this._vecTeamInfo[_loc_3].memberid.equal(_loc_1))
                    {
                        return this._vecTeamInfo[_loc_3];
                    }
                    _loc_3++;
                }
            }
            return null;
        }// end function

        public static function getInstance() : TeamModel
        {
            if (!_instance)
            {
                _instance = new TeamModel;
            }
            return _instance;
        }// end function

    }
}
