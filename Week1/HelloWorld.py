import cv2

# Create a VideoCapture object
capture = cv2.VideoCapture(0)

# Check if camera opened successfully
if (capture.isOpened() == False):
  print("Unable to read camera")

# Convert the resolutions from float to integer
frame_width = int(capture.get(3))
frame_height = int(capture.get(4))

# Define the codec and create VideoWriter object
# The output will be stored in 'webcam.avi' file
output = cv2.VideoWriter('webcam.avi', cv2.VideoWriter_fourcc(*'MJPG'), 30, (frame_width, frame_height))

while(True):
  ret, frame = capture.read()
  if ret == True:
    # Write the frame into the file 'webcam.avi'
    output.write(frame)
    # Display the resulting frame 
    cv2.imshow('Your webcam', frame)
    # Press q on keyboard to stop recording
    if cv2.waitKey(1) & 0xFF == ord('q'):
      break
  # Break the loop
  else:
    break 

# When everything done, release the video capture and video write objects
capture.release()
output.release()

# Closes all the frames
cv2.destroyAllWindows() 