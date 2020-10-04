let Svid;
let Ivid;
let Simg;// array of frames of student
let Iimg;//array of frames of Instructor
let neti;
let nets;
let posei;
let poses;

const fsLibrary  = require('fs') 

async function setup() {
  //take video
  // code...{video of student stored in Svid and that of instructor in Ivid}}
  //compress the smaller of 2 vids to match the size of smaller video

  //you  got the video not break it into poses
  breakv(Svid,Simg);
  //now do same for video of instructor
  breakv(Ivid,Iimg);
  frames=Simg.length;
  // a for loop to apply posenet on both the images
  for(i=0;i<frames;i++)
  {
     nets = await posenet.load();
     poses = await nets.estimateSinglePose(Simg[i], {
       flipHorizontal: false
      });
     neti = await posenet.load();
     posei = await neti.estimateSinglePose(Iimg[i], {
       flipHorizontal: false
      });
     // a compare function to compare yout fults 
     compare();
     draw();
  // a message to tell you your faults stating explicitly
  }
  
}
function compare(){
  // what matters is 
  // 1.angle between the line joining your shoulder to hip and the line joining your shoulder to elbow 
  // 2.angle between the line joining your elbow to wrist and the line joining your shoulder to elbow 
  //3.hip to knee and knee to ankle
  //4. right hip to right knee and left hip to left knee
  // the program calculates the angle of these 4 configurations of the instructor and that of student and then stells the angle difference
  //of the student and instructor and tells the percentage error and then tells where was the error and how much should we move inwarde or outwards
  let data;
  let ones;
  let onei;
  let percentage;
  let move;
  let slope1;
  let slope2;
  slope1=((posei.rightShoulder.y)-(posei.rightHip.y))/((posei.rightShoulder.x)-(posei.rightHip.x));
  slope2=((posei.rightShoulder.y)-(posei.rightElbow.y))/((posei.rightShoulder.x)-(posei.rightElbow.x));
  onei=Math.atan(slope1-slope2);
  slope1=((poses.rightShoulder.y)-(poses.rightHip.y))/((poses.rightShoulder.x)-(poses.rightHip.x));
  slope2=((poses.rightShoulder.y)-(poses.rightElbow.y))/((poses.rightShoulder.x)-(poses.rightElbow.x));
  ones=Math.atan(slope1-slope2);
  let error=((onei-ones)/onei)*100;
  data=error.toString(error);
  if(error<0){data+", move elbow inwards";}
  else {data+", move elbow  outwards";}
  fsLibrary.writeFile('newfile.txt', data, (error) => { if (error) throw err;})

}


function breakv(video,arr) {
    var canvas = document.getElementById('canvas');     
    canvas.width = video.videoWidth;
    canvas.height = video.videoHeight;
    canvas.getContext('2d').drawImage(video, 0, 0, video.videoWidth, video.videoHeight);  
    canvas.toBlob() = (blob) => {
      arr.push(blob);
    };
}


