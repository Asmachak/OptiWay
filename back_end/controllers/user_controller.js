
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
        city : formData.city,
        country : formData.country
      });

      const myToken = generateToken(user.toJSON());
      return res.status(200).json({ token: myToken, id : user.id , email : user.email , name : user.name , last_name : user.last_name , phone : user.phone , photo : user.photo , password : user.password , address : user.address , city : user.city, country : user.country});
      
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
      city: updatedUserData.city || existingUser.city,
      country: updatedUserData.country || existingUser.country,
    });

    const user = await User.findByPk(userId);
    const myNewToken=generateToken(user.toJSON());
    console.log(myNewToken)
    return res.status(200).json({ token: myNewToken, id : user.id , email : user.email , name : user.name , last_name : user.last_name , phone : user.phone , photo : user.photo , password : user.password , address : user.address, city : user.city, country : user.country,deviceId:user.deviceId});

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
    return res.status(200).json({ token: myNewToken, id : user.id , email : user.email , name : user.name , last_name : user.last_name , phone : user.phone , photo : user.photo , password : user.password , address : user.address, city : user.city, country : user.country,deviceId:user.deviceId});

  } catch (error) {
        // Handle errors
        console.error(error);
        res.status(500).json({ success: false, error: 'Something went wrong in upload image' });
  }
};

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
};

async function editPassword(req, res) {
  try {
    const userId = req.params.userId;
    const existingUser = await User.findByPk(userId);
    const formData = req.body;

    if (!existingUser) {
      console.log("User does not exist");
      return res.status(400).json({ msg: "User does not exist" });
    }

    const isPasswordMatch = await bcrypt.compare(
      formData.password,
      existingUser.password
    );

    if (!isPasswordMatch) {
      console.log("Password does not match");
      return res.status(400).json({ msg: "Verifier vos données" });
    }

    const newHashedPassword = await bcrypt.hash(formData.newPassword, 10);
    await existingUser.update({ password: newHashedPassword });
    const user = await User.findByPk(userId);
    const myNewToken=generateToken(user.toJSON());

    return res.status(200).json({
      token: myNewToken,
      id: existingUser.id,
      email: existingUser.email,
      name: existingUser.name,
      last_name: existingUser.last_name,
      phone: existingUser.phone,
      photo: existingUser.photo,
      password: existingUser.password, 
      address: existingUser.address,
      city: existingUser.city,
      country: existingUser.country,
      deviceId:existingUser.deviceId
    });
  } catch (error) {
    console.log("Error:", error);
    return res.status(500).json({ msg: "Internal Server Error" });
  }
};

async function forgetPassword(req, res) {
  try {
    const formData = req.body;
  
      const existingUser = await User.findOne({
        where: {
          email: formData.email
        }
      });


    if (!existingUser) {
      console.log("User does not exist");
      return res.status(400).json({ msg: "User does not exist" });
    }

    const newHashedPassword = await bcrypt.hash(formData.newPassword, 10);
    await existingUser.update({ password: newHashedPassword });
    const user = await User.findByPk(existingUser.id);
    const myNewToken=generateToken(user.toJSON());

    return res.status(200).json({
      token: myNewToken,
      id: existingUser.id,
      email: existingUser.email,
      name: existingUser.name,
      last_name: existingUser.last_name,
      phone: existingUser.phone,
      photo: existingUser.photo,
      password: existingUser.password, 
      address: existingUser.address,
      city: existingUser.city,
      country: existingUser.country,
      deviceId:existingUser.deviceId
    });
  } catch (error) {
    console.log("Error:", error);
    return res.status(500).json({ msg: "Internal Server Error" });
  }
}

async function getAllUsers(req, res) {
  try {
    const users = await User.findAll();
    
    // Return users as part of an object, in case you want to add more info later
    res.status(200).send(users);
    
  } catch (error) {
    console.error("Error retrieving users:", error);
    
    // More detailed error response
    res.status(500).json({
      success: false,
      message: "An error occurred while fetching users",
      error: error.message, // Optionally expose error details
    });
  }
}



module.exports={handleAddUser,updateUser,deleteUser,uploadImage,editPassword,forgetPassword,getAllUsers}