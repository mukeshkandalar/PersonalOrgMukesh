import { LightningElement, track } from 'lwc';

export default class MeetingRoomsParent extends LightningElement {
   @track selectedMeetingRoom;
    meetingRoomsInfo =[
        {roomName:'A-01', roomCapacity:'8'},
        {roomName:'B-01', roomCapacity:'8'},
        {roomName:'C-01', roomCapacity:'8'},
        {roomName:'A-02', roomCapacity:'16'}
    ];
    ontileSelectHandler(event){
        const meetingRoomInfo = event.detail;
        this.selectedMeetingRoom = meetingRoomInfo.roomName;
    }
    constructor(){
        super();
        this.template.addEventListener('tileClick',this.ontileSelectHandler.bind(this));
    }
}