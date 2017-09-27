var userListData = [];
var updating;

// DOM Ready 
$(document).ready(function() {
    populateTable();
    $('#userList table tbody').on('click', 'td a.linkshowuser', showUserInfo);
    $('#btnAddUser').on('click', addUser);
    $('#userList table tbody').on('click', 'td a.linkdeleteuser', deleteUser);
    $('#btnUpdateUser').on('click', updateUser);
});

// Functions 

function populateTable() {
    var tableContent = '';
    $.getJSON( '/users/userlist', function( data ) {
        userListData = data.students;
        $.each(userListData, function(){
            tableContent += '<tr>';
            tableContent += '<td><a href="#" class="linkshowuser" rel="' + this._id + '" title="Show Details">' + this.nim + '</a></td>';
            tableContent += '<td>' + this.name + '</td>';
            tableContent += '<td>' + this.course + '</td>';
            tableContent += '<td>' + this.score + '</td>';
            tableContent += '<td><a href="#" class="linkdeleteuser" rel="' + this._id + '">delete</a></td>';
            tableContent += '</tr>';
        });
        $('#userList table tbody').html(tableContent);
    });
};

function showUserInfo(event) {
    event.preventDefault(); // Prevent Link from Firing
    var thisUserName = $(this).attr('rel');
    updating = thisUserName;
    var arrayPosition = userListData.map(function(arrayItem) { return arrayItem._id; }).indexOf(thisUserName); // Get Index of object based on id value
    var thisUserObject = userListData[arrayPosition];

    $('#userInfoName').val(thisUserObject.name);
    $('#userInfoNim').val(thisUserObject.nim);
    $('#userInfoCourse').val(thisUserObject.course);
    $('#userInfoScore').val(thisUserObject.score);
};

function addUser(event) {
    event.preventDefault();
    var errorCount = 0;
    $('#addUser input').each(function(index, val) {
        if($(this).val() === '') { errorCount++; }
    });

    if(errorCount === 0) {
        var newUser = {
            'name': $('#addUser fieldset input#inputUserName').val(),
            'nim': $('#addUser fieldset input#inputUserNim').val(),
            'course': $('#addUser fieldset input#inputUserCourse').val(),
            'score': $('#addUser fieldset input#inputUserScore').val(),
        }

        $.ajax({
            type: 'POST',
            data: newUser,
            url: '/users/adduser',
            dataType: 'JSON'
        }).done(function( response ) {
            if (response.msg === '') {
                $('#addUser fieldset input').val('');
                populateTable();
            }
            else {
                alert('Error: ' + response.msg);
            }
        });
    }
    else {
        alert('Please fill in all fields');
        return false;
    }
};

function deleteUser(event) {
    event.preventDefault();
    var confirmation = confirm('Are you sure you want to delete this user?');
    if (confirmation === true) {
        $.ajax({
            type: 'DELETE',
            url: '/users/deleteuser/' + $(this).attr('rel')
        }).done(function( response ) {
            if (response.msg === '') {
            }
            else {
                alert('Error: ' + response.msg);
            }
            populateTable();
        });
    }
    else {
        return false;
    }
};

function updateUser(event) {
    event.preventDefault();
    var updateUser = {
            'nim': $('#userInfo input#userInfoNim').val(),
            'name': $('#userInfo input#userInfoName').val(),
            'course': $('#userInfo input#userInfoCourse').val(),
            'score': $('#userInfo input#userInfoScore').val()
        }
    $.ajax({
        type: 'PUT',
        data: updateUser,
        url: '/users/updateuser/' + updating,
        dataType: 'JSON'
    }).done(function( response ) {
        if (response.msg === '') {
            $('#userInfo input').val('');
            }
            else {
                alert('Error: ' + response.msg);
            }
        });
    populateTable();
};