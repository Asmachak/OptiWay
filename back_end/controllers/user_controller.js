
const {generateToken} = require('../middleware/jwt')
const bcrypt = require('bcrypt');
const defaultImageBuffer = 'https://i.pinimg.com/736x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg';
const {handleImageUploadAsync} = require('../middleware/cloudinary')
const multer = require('multer');
const {generateID} = require("../middleware/generateID");
const User = require('../models/user');



async function handleAddUser (req,res)

 {
    try {
      const formData = req.body;
  
      // Check if client with the same email exists
      const existingUser = await User.findOne({
        where: {
          email: formData.email
        }
      });
  
      if (existingUser) {
        
        return res.status(400).json({msg:"try another Email adress"});
      }

      const idUser = generateID();

      // Create a new user
      const user = await User.create({
        id : idUser,
        last_name: formData.last_name,
        name: formData.name,
        email: formData.email,
        phone: formData.phone,
        address: formData.address,
        password: await bcrypt.hash(formData.password, 10), // Ensure to hash this password before saving
        photo : defaultImageBuffer,
      });

      const myToken = generateToken(user.toJSON());
      return res.status(200).json({ token: myToken, id : user.id , email : user.email , name : user.name , last_name : user.last_name , phone : user.phone , photo : user.photo , password : user.password , address : user.address});
      
    } catch (error) {
      console.error("Error:", error);
      res.status(500).send("Error is occured when handle Add user");
    }
};

async function updateUser (req, res) {
  try {
    const userId = req.params.userId;

    const existingUser = await User.findByPk(userId);

    if (!existingUser) {
      return res.status(404).json({ error: 'User not found' });
    }

    const updatedUserData = req.body;

    console.log(updatedUserData);

    console.log("exist ",existingUser);

   await existingUser.update({
      last_name: updatedUserData.last_name || existingUser.last_name,
      name: updatedUserData.name || existingUser.name,
      phone: updatedUserData.phone || existingUser.phone,
      address: updatedUserData.address || existingUser.address,
      email: updatedUserData.email || existingUser.email,
    });

    const user = await User.findByPk(userId);
    const myNewToken=generateToken(user.toJSON());
    console.log(myNewToken)
    return res.status(200).json({ token: myNewToken, id : user.id , email : user.email , name : user.name , last_name : user.last_name , phone : user.phone , photo : user.photo , password : user.password , address : user.address});

  } catch (error) {
    // Handle errors
    console.error(error);
    res.status(500).json({ success: false, error: 'Something went wrong in updateUser' });
  }
};

async function uploadImage(req,res){
  try {
    // Wait for the uploadPromise to resolve or reject
    const imageUrl = await handleImageUploadAsync(req, res);

    // Now you have the imageUrl, you can use it as needed
    console.log('Image URL:', imageUrl);

    let myImage = defaultImageBuffer;

    if(imageUrl.length){
      myImage = imageUrl ;
    }

    const userId = req.params.userId;

    const existingUser = await User.findByPk(userId);

    if (!existingUser) {
      return res.status(404).json({ error: 'User not found' });
    }
    await existingUser.update({
     photo : myImage,
    });
    const user = await User.findByPk(userId);
    const myNewToken=generateToken(user.toJSON());
    console.log(myNewToken)
    return res.status(200).json({ token: myNewToken, id : user.id , email : user.email , name : user.name , last_name : user.last_name , phone : user.phone , photo : user.photo , password : user.password , address : user.address});

  } catch (error) {
        // Handle errors
        console.error(error);
        res.status(500).json({ success: false, error: 'Something went wrong in upload image' });
  }
}
async function deleteUser(req,res){
try {
  const userId = req.params.userId;

  const existingUser = await User.findByPk(userId);

  if (!existingUser) {
    return res.status(404).json({ error: 'User not found' });
  }

  await User.destroy({
    where: {
      id: userId
    }
  });

  res.status(200).json("user deleted");

  
} catch (error) {
  console.error("Error:", error);
  res.status(500).send("Error is occured when deleting user !!");
  
}
}


module.exports={handleAddUser,updateUser,deleteUser,uploadImage}